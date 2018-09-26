# coding:utf8
from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, IntegerField,SubmitField, FileField, TextAreaField, SelectField, SelectMultipleField
from wtforms.validators import DataRequired, ValidationError,EqualTo
from app.models import Admin,Auth,Role



class LoginForm(FlaskForm):
    """ the login form for the admin"""
    account = StringField(
        label="账号",
        validators=[
            DataRequired(" please input the account")],
        description="account",
        render_kw={

            "class": "form-control",
            "placeholder": "请输入账号！",
            "required": "required"
        }

    )

    pwd = PasswordField(
        label="密码",
        validators=[DataRequired("please input the password")],
        description='password',
        render_kw={
            "class": "form-control",
            "placeholder": "请输入password！",
            "required": "required"
        }
    )

    submit = SubmitField(
        "登录",
        render_kw={
            "class": "btn btn-primary btn-block btn-flat"
        }
    )

    def validate_account(self, field):
        account = field.data
        admin = Admin.query.filter_by(name=account).count()
        if admin == 0:
            raise ValidationError(" account not exist")

class MovieForm(FlaskForm):
    id = IntegerField(
        label="movieId",
        validators=[
            DataRequired("please input movie id")
        ],
        description="movie_id",
        render_kw={
            "class": "form-control",
            "id": "input_id",
            "placeholder": "movie id*",
        })
    title = StringField(
        label="moviename",
        validators=[
            DataRequired("please input moviename")
        ],
        description="movie_name",
        render_kw={
            "class": "form-control",
            "id": "input_name",
            "placeholder": "movie name！",
        })
    title_without_year = StringField(
        label="moviename without year",
        validators=[
            DataRequired("please input title_without_year")
        ],
        description="movie_name",
        render_kw={
            "class": "form-control",
            "id": "input_name",
            "placeholder": "title_without_year *！",
        })
    submit = SubmitField(
        "edit",
        render_kw={
            "class": "btn btn-primary"
        }
    )
    youtubeId = StringField(
        label="youtubeID",
        validators=[
            DataRequired(" please provide the youtube Id")],
        description="place",
        render_kw={

            "class": "form-control",
            "placeholder": "please provide the youtube Id！",
        }

    )
    add_time = StringField(
        label="add time",
        validators=[
            DataRequired(" please select the Add time")],
        description="time of release",
        render_kw={

            "class": "form-control",
            "placeholder": "select movie Add time！",
            "id": "input_add_time"
        }
    )


'''
class PreviewForm(FlaskForm):
    title = StringField(
        label="预告标题",
        validators=[
            DataRequired("预告标题不能为空！")
        ],
        description="预告标题",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入预告标题！"
        }
    )
    logo = FileField(
        label="预告封面",
        validators=[
            DataRequired("预告封面不能为空！")
        ],
        description="预告封面",
    )
    submit = SubmitField(
        '编辑',
        render_kw={
            "class": "btn btn-primary",
        }
    )
    '''
class PwdForm(FlaskForm):
    old_pwd=PasswordField(
        label="old 密码",
        validators=[DataRequired("please input the password")],
        description='password',
        render_kw={
            "class": "form-control",
            "placeholder": "请输入 old password！",
            #"required": "required"
        }
    )
    new_pwd = PasswordField(
        label="new 密码",
        validators=[DataRequired("please input the password")],
        description='password',
        render_kw={
            "class": "form-control",
            "placeholder": "请输入 new password！",
            # "required": "required"
        }
    )
    submit = SubmitField(
        '编辑',
        render_kw={
            "class": "btn btn-primary",
        }
    )
    def validate_old_pwd(self,field):
        from flask import session
        pwd=field.data
        name=session["admin"]
        admin=Admin.query.filter_by(
            name=name
        ).first()
        if not admin.check_pwd(pwd):
            raise ValidationError("old password is wrong")



class AuthForm(FlaskForm):
    name = StringField(
        label="权限名称",
        validators=[
            DataRequired("权限名称不能为空！")
        ],
        description="权限名称",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入权限名称！"
        }
    )
    url = StringField(
        label="权限地址",
        validators=[
            DataRequired("权限地址不能为空！")
        ],
        description="权限地址",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入权限地址！"
        }
    )
    submit = SubmitField(
        '编辑',
        render_kw={
            "class": "btn btn-primary",
        }
    )

class RoleForm(FlaskForm):
    name = StringField(
        label="角色名称",
        validators=[
            DataRequired("角色名称不能为空！")
        ],
        description="角色名称",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入角色名称！"
        }
    )
    # 多选框
    auths = SelectMultipleField(
        label="权限列表",
        validators=[
            DataRequired("权限列表不能为空！")
        ],
        # 动态数据填充选择栏：列表生成器
        coerce=int,
        choices=[(v.id, v.name) for v in Auth.query.all()],
        description="权限列表",
        render_kw={
            "class": "form-control",
        }
    )
    submit = SubmitField(
        '编辑',
        render_kw={
            "class": "btn btn-primary",
        }
    )

class AuthForm(FlaskForm):
    name = StringField(
        label="权限名称",
        validators=[
            DataRequired("权限名称不能为空！")
        ],
        description="权限名称",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入权限名称！"
        }
    )
    url = StringField(
        label="权限地址",
        validators=[
            DataRequired("权限地址不能为空！")
        ],
        description="权限地址",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入权限地址！"
        }
    )
    submit = SubmitField(
        '编辑',
        render_kw={
            "class": "btn btn-primary",
        }
    )


class RoleForm(FlaskForm):
    name = StringField(
        label="角色名称",
        validators=[
            DataRequired("角色名称不能为空！")
        ],
        description="角色名称",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入角色名称！"
        }
    )
    # 多选框
    auths = SelectMultipleField(
        label="权限列表",
        validators=[
            DataRequired("权限列表不能为空！")
        ],
        # 动态数据填充选择栏：列表生成器
        coerce=int,
        choices=[(v.id, v.name) for v in Auth.query.all()],
        description="权限列表",
        render_kw={
            "class": "form-control",
        }
    )
    submit = SubmitField(
        '编辑',
        render_kw={
            "class": "btn btn-primary",
        }
    )


class AdminForm(FlaskForm):
    name = StringField(
        label="管理员名称",
        validators=[
            DataRequired("管理员名称不能为空！")
        ],
        description="管理员名称",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入管理员名称！",
        }
    )
    pwd = PasswordField(
        label="管理员密码",
        validators=[
            DataRequired("管理员密码不能为空！")
        ],
        description="管理员密码",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入管理员密码！",
        }
    )
    repwd = PasswordField(
        label="管理员重复密码",
        validators=[
            DataRequired("管理员重复密码不能为空！"),
            EqualTo('pwd', message="两次密码不一致！")
        ],
        description="管理员重复密码",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入管理员重复密码！",
        }
    )
    role_id = SelectField(
        label="所属角色",
        coerce=int,
        choices=[(v.id, v.name) for v in Role.query.all()],
        render_kw={
            "class": "form-control",
        }
    )
    submit = SubmitField(
        '编辑',
        render_kw={
            "class": "btn btn-primary",
        }
    )



