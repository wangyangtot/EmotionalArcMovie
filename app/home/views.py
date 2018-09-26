# coding:utf8
from . import home
from flask import render_template, redirect, url_for, flash, session, request
from app.home.forms import RegistForm, LoginForm, UserdetailForm, PwdForm, CommentForm
from app.models import User, Userlog, Movie, Comment, Moviecol
from werkzeug.security import generate_password_hash
from werkzeug.utils import secure_filename
import uuid
from app import db, app
from functools import wraps
import os
import datetime
import pandas as pd
import json
import pickle
import numpy as np


def user_login_req(f):
    """
    登录装饰器
    """

    @wraps(f)
    def decorated_function(*args, **kwargs):
        if "user" not in session:
            return redirect(url_for("home.login", next=request.url))
        return f(*args, **kwargs)

    return decorated_function


def change_filename(filename):
    """
    修改文件名称
    """
    fileinfo = os.path.splitext(filename)
    filename = datetime.datetime.now().strftime("%Y%m%d%H%M%S") + \
               str(uuid.uuid4().hex) + fileinfo[-1]
    return filename

@home.route("/test/", methods=["GET"])
def test():
    return render_template("home/test.html")


@home.route("/link/", methods=["GET"])
def link():
    d2 = pd.read_csv('static/link/sentiment_2d.csv')
    line = pd.read_csv('static/link/sentiment_line.csv')
    d2_data = d2.to_dict(orient='records')
    line_data=line.to_dict(orient='records')
    d2_data = json.dumps(d2_data, indent=4)
    line_data=json.dumps(line_data, indent=4)
    data = {'scatter_data': d2_data,'line_data':line_data};
    return render_template("home/linked.html",data=data)


@home.route("/<int:page>/", methods=["GET"])
@home.route("/", methods=["GET"])
def mood():
    d2= pd.read_csv('static/mood/d2_sentiment.csv')
    line = pd.read_csv('static/mood/sentiment_line.csv')
    d2_data = d2.to_dict(orient='records')
    line_data = line.to_dict(orient='records')
    data = json.dumps(d2_data, indent=4)
    data = {'scatter_data': data,'line_data':line_data};
    return render_template("home/index.html",data=data)


@home.route("/change_recommend_movie", methods=["GET", "POST"])
def change_recommend_movie():
    if request.method == "GET":
        range_value = request.args.get("range_value", 'a'),
        range_value = float(range_value[0])
        movie_name = request.args.get("title", 'a')
        print(range_value)
        print(movie_name)
        with open('static/mood/title2id.pkl', 'rb') as f:
            title2id = pickle.load(f, encoding='latin1')
        id = title2id[movie_name]['id']
        with open('static/mood/ids2genome_sim_index.pkl', 'rb') as f:
            ids2genome_sim_index = pickle.load(f, encoding='latin1')
        index = ids2genome_sim_index[id]
        genome_sim_Matrix = np.load('static/mood/genome_similarities_Matrix.npy')
        recommend_index_by_genome = np.argsort(genome_sim_Matrix[index])[::-1][1:100].tolist()
        genome_similarities=np.sort(genome_sim_Matrix[index])[::-1][1:100]
        with open('static/mood/ids2genome_sim_index.pkl', 'rb') as f:
            ids2genome_sim_index = pickle.load(f, encoding='latin1')
        genome_sim_index2ids = dict(zip(ids2genome_sim_index.values(), ids2genome_sim_index.keys()))
        recommend_id_by_genome = [genome_sim_index2ids[x] for x in recommend_index_by_genome]
        movies = pd.read_pickle('static/mood/movies.pkl')
        recommend_title_by_genome=[]
        for i in recommend_id_by_genome:
            recommend_title_by_genome += (movies[movies['movieId'] == i]['title_without_year'].values.tolist());
        #print(recommend_title_by_genome)
        with open('static/mood/movie_name2sentiment_sim_index.pkl', 'rb') as f:
            movie_name2sentiment_sim_index = pickle.load(f, encoding='latin1')
        recommend_index_in_sentiment=[movie_name2sentiment_sim_index[i] for i in recommend_title_by_genome]
        sentiment_sim_Matrix = np.load('static/mood/sentiment_similarities_Matrix.npy')
        sentiment_similarities=np.asarray([sentiment_sim_Matrix[index][j] if (j<len(sentiment_sim_Matrix) and index<len(sentiment_sim_Matrix)) else 0 for j in recommend_index_in_sentiment ])
        total_similarities=genome_similarities*(1-range_value)+sentiment_similarities*range_value
        select_index=np.argsort(total_similarities)[::-1][:8]
        final_id=[recommend_id_by_genome[i] for i in select_index]
        final_title=[recommend_title_by_genome[i] for i in select_index]
        #final_title = movies[movies['movieId'].isin(final_id)]['title_without_year'].values
        final_title = [i.replace(' ', '+') for i in final_title]
        print("change recommend")
        print(final_title)
        print(final_id)
        data = {"recMovieTitle": final_title,"recMovieId":final_id}
        return json.dumps(data, indent=4)




@home.route("/recommend", methods=["GET", "POST"])
def get_recommend_content():
    if request.method == "GET":
        movie_name =request.args.get("movie",'a'),
        movie_name=movie_name[0]
        genome_simMatrix =np.load('static/mood/genome_similarities_Matrix.npy')
    with open('static/mood/title2id.pkl','rb') as f:
        title2id= pickle.load(f,encoding='latin1')
    id=title2id[movie_name]['id']
    with open('static/mood/ids2genome_sim_index.pkl', 'rb') as f:
        ids2genome_sim_index = pickle.load(f, encoding='latin1')
    index=ids2genome_sim_index[id]
    recommend_index = np.argsort(genome_simMatrix[index])[::-1][1:10].tolist()
    genome_sim_index2ids = dict(zip(ids2genome_sim_index.values(), ids2genome_sim_index.keys()))
    recommend_id=[genome_sim_index2ids[x] for x in recommend_index]
    movies = pd.read_pickle('static/mood/movies.pkl')
    print (recommend_id)
    recommend_title=[];
    for i  in recommend_id:
        recommend_title+=(movies[movies['movieId']==i]['title_without_year'].values.tolist());
    recommend_title=[i.replace(' ','+') for i in recommend_title]
    data={"recMovieTitle":recommend_title,'recMovieId':recommend_id}
    print ("recooment:")
    print (data)
    return json.dumps(data,indent=4)


@home.route("/player/<int:id>/<int:page>/", methods=["GET", "POST"])
def player(id=None, page=None):
    movie = Movie.query.filter(
        Movie.id == int(id)
    ).first_or_404()

    if page is None:
        page = 1
    page_data = Comment.query.join(
        Movie
    ).join(
        User
    ).filter(
        Movie.id == movie.id,
        User.id == Comment.user_id
    ).order_by(
        Comment.addtime.desc()
    ).paginate(page=page, per_page=5)
    form = CommentForm()
    if "user" in session and form.validate_on_submit():
        data = form.data
        comment = Comment(
            content=data["content"],
            movie_id=movie.id,
            user_id=session["user_id"]
        )
        db.session.add(comment)
        db.session.commit()
        movie.commentnum = movie.commentnum + 1
        db.session.add(movie)
        db.session.commit()
        flash("添加评论成功！", "ok")
        return redirect(url_for('home.play', id=movie.id, page=1))
    # 放在后面避免添加评论播放量涨2
    movie.playnum = movie.playnum + 1
    db.session.add(movie)
    db.session.commit()
    return render_template("home/player.html",movie=movie, form=form, page_data=page_data)



@home.route("/find_line_points", methods=["GET"])
def find_line_points():
    if request.method == "GET":
        movie_name =request.args.get("id",'a'),
        movie_name=movie_name[0]
        #print(movie_name)
        with open('static/mood/sentiment_line.pkl', 'rb') as f:
            sentiment_line = pickle.load(f, encoding='latin1')
            points=sentiment_line[movie_name]
            #print(points)
            data={"line_points":points}
    return json.dumps(data,indent=4)







@home.route("/login/", methods=["GET", "POST"])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        data = form.data
        user = User.query.filter_by(email=data['email']).first()
        if user:
            if not user.check_pwd(data['pwd']):
                flash("password is wrong", "err")
                return redirect(url_for("home.login"))
        else:
            flash("Email does not exist！", "err")
            return redirect(url_for("home.login"))
        session['user'] = user.name
        session['user_id'] = user.id
        userlog = Userlog(
            user_id=user.id,
            ip=request.remote_addr,
        )
        db.session.add(userlog)
        db.session.commit()
        return redirect(url_for("home.user"))
    return render_template("home/login.html", form=form)


@home.route("/logout/")
def logout():
    session.pop("user", None)
    session.pop("user_id", None)
    return redirect(url_for("home.login"))


@home.route("/regist/", methods=["GET", "POST"])
def regist():
    form = RegistForm()
    if form.validate_on_submit():
        data = form.data
        user = User(
            name=data['name'],
            email=data['email'],
            phone=data['phone'],
            pwd=generate_password_hash(data["pwd"]),
            uuid=uuid.uuid4().hex
        )
        db.session.add(user)
        db.session.commit()
        flash("register successfully !", 'ok')

    return render_template("home/regist.html", form=form)


# 会员修改资料
@home.route("/user/", methods=["GET", "POST"])
def user():
    form = UserdetailForm()
    user = User.query.get(int(session['user_id']))
    form.face.validators = []
    if request.method == "GET":
        # 赋初值
        #form.name.data = user.name
        form.email.data = user.email
        form.info.data = user.info
    if form.validate_on_submit():
        data = form.data
        if form.face.data != "":
            file_face = secure_filename(form.face.data.filename)
            if not os.path.exists(app.config["FC_DIR"]):
                os.makedirs(app.config["FC_DIR"])
                os.chmod(app.config["FC_DIR"], "rw")
            user.face = change_filename(file_face)
            form.face.data.save(app.config["FC_DIR"] + user.face)

        email_count = User.query.filter_by(email=data["email"]).count()
        if data["email"] != user.email and email_count == 1:
            flash("邮箱已经存在!", "err")
            return redirect(url_for("home.user"))
        user.email = data["email"]
        user.info = data["info"]
        db.session.add(user)
        db.session.commit()
        flash("修改成功!", "ok")
        return redirect(url_for("home.user"))
    return render_template("home/user.html", form=form, user=user)


@home.route("/pwd/", methods=["GET", "POST"])
@user_login_req
def pwd():
    """
    修改密码
    """
    form = PwdForm()
    if form.validate_on_submit():
        data = form.data
        user = User.query.filter_by(name=session["user"]).first()
        if not user.check_pwd(data["old_pwd"]):
            flash("旧密码错误！", "err")
            return redirect(url_for('home.pwd'))
        user.pwd = generate_password_hash(data["new_pwd"])
        db.session.add(user)
        db.session.commit()
        flash("修改密码成功，请重新登录！", "ok")
        return redirect(url_for('home.logout'))
    return render_template("home/pwd.html", form=form)


@home.route("/comments/<int:page>/")
@user_login_req
def comments(page=None):
    if page is None:
        page = 1
    page_data = Comment.query.join(
        Movie
    ).join(
        User
    ).filter(
        Movie.id == Comment.movie_id,
        User.id == session['user_id']
    ).order_by(
        Comment.addtime.desc()
    ).paginate(page=page, per_page=7)
    return render_template("home/comments.html", page_data=page_data)


@home.route("/loginlog/<int:page>/", methods=["GET"])
@user_login_req
def loginlog(page=None):
    """
    会员登录日志
    """
    if page is None:
        page = 1
    page_data = Userlog.query.filter_by(
        user_id=int(session["user_id"])
    ).order_by(
        Userlog.addtime.desc()
    ).paginate(page=page, per_page=10)
    return render_template("home/loginlog.html", page_data=page_data)


@home.route("/moviecol/add/", methods=["GET"])
# @user_login_req
def moviecol_add():
    """
    添加电影收藏
    """
    uid = request.args.get("uid", "")
    mid = request.args.get("mid", "")
    moviecol = Moviecol.query.filter_by(
        user_id=int(uid),
        movie_id=int(mid)
    ).count()
    # 已收藏
    if moviecol == 1:
        data = dict(ok=0)
    # 未收藏进行收藏
    if moviecol == 0:
        moviecol = Moviecol(
            user_id=int(uid),
            movie_id=int(mid)
        )
        db.session.add(moviecol)
        db.session.commit()
        data = dict(ok=1)
    import json
    return json.dumps(data)


@home.route("/moviecol/<int:page>/")
def moviecol(page=None):
    if page is None:
        page = 1
    page_data = Moviecol.query.join(
        Movie
    ).join(
    User
    ).filter(
         Movie.id == Moviecol.movie_id,
         User.id==session["user_id"]
    ).order_by(
    Moviecol.addtime.desc()
    ).paginate(page=page, per_page=1)
    return render_template("home/moviecol.html",page_data=page_data)




# 首页
'''
@home.route("/<int:page>/", methods=["GET"])
@home.route("/", methods=["GET"])
def index(page=None):
    """
    首页电影列表
    """
    return render_template(
        "home/index.html",)
'''

''''@home.route("/animation/")
def animation():
    data = Preview.query.all()
    for v in data:
        v.id = v.id - 1
    return render_template("home/animation.html", data=data)
'''

@home.route("/search/<int:page>/")
def search(page=None):
    if page is None:
        page = 1
    key = request.args.get("key", "")
    movie_count = Movie.query.filter(
        Movie.title.ilike('%' + key + '%')
    ).count()
    page_data = Movie.query.filter(
        Movie.title.ilike('%' + key + '%')
    ).order_by(
        Movie.id.desc()
    ).paginate(page=page, per_page=10)
    page_data.key = key
    return render_template("home/search.html", movie_count=movie_count, key=key, page_data=page_data)


@home.route("/play/<int:id>/<int:page>/", methods=["GET", "POST"])
def play(id=None, page=None):
    """
    播放电影
    """
    movie = Movie.query.join(Tag).filter(
        Tag.id == Movie.tag_id,
        Movie.id == int(id)
    ).first_or_404()

    if page is None:
        page = 1
    page_data = Comment.query.join(
        Movie
    ).join(
        User
    ).filter(
        Movie.id == movie.id,
        User.id == Comment.user_id
    ).order_by(
        Comment.addtime.desc()
    ).paginate(page=page, per_page=5)
    form = CommentForm()
    if "user" in session and form.validate_on_submit():
        data = form.data
        comment = Comment(
            content=data["content"],
            movie_id=movie.id,
            user_id=session["user_id"]
        )
        db.session.add(comment)
        db.session.commit()
        movie.commentnum = movie.commentnum + 1
        db.session.add(movie)
        db.session.commit()
        flash("添加评论成功！", "ok")
        return redirect(url_for('home.play', id=movie.id, page=1))
    # 放在后面避免添加评论播放量涨2
    movie.playnum = movie.playnum + 1
    db.session.add(movie)
    db.session.commit()
    return render_template("home/play.html", movie=movie, form=form, page_data=page_data)


