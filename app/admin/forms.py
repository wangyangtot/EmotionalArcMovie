# coding:utf8
from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField, FileField, TextAreaField, SelectField, SelectMultipleField
from wtforms.validators import DataRequired, ValidationError,EqualTo
from app.models import Admin, Tag,Auth,Role



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


class TagForm(FlaskForm):
    name = StringField(
        label="name",
        validators=[
            DataRequired("please input label")
        ],
        description="label",
        render_kw={
            "class": "form-control",
            "id": "input_name",
            "placeholder": "请输入标签名称！",
        })

    submit = SubmitField(
        "edit",
        render_kw={
            "class": "btn btn-primary"
        }
    )


class MovieForm(FlaskForm):
    title = StringField(
        label="moviename",
        validators=[
            DataRequired("please input moviename")
        ],
        description="movie_name",
        render_kw={
            "class": "form-control",
            "id": "input_name",
            "placeholder": "请输入片名！",
        })
    url = FileField(
        label='file',
        validators=[
            DataRequired("please upload file")
        ],
        description="file name",

    )
    info = TextAreaField(
        label="简介",
        validators=[
            DataRequired("please input jianjie")
        ],
        description="movie_name",
        render_kw={
            "class": "form-control",
            "rows": 10,
        }
    )
    logo = FileField(
        label="封面",
        validators=[
            DataRequired("please input 封面")
        ],
        description="cover",
    )
    star = SelectField(
        label="star level",
        validators=[
            DataRequired("please select star")
        ],
        coerce=int,
        choices=[(1, "1 star"), (2, "2 star"), (3, "3 star"), (4, "4 star"), (4, "4 star")],
        description="star",
        render_kw={
            "class": "form-control",
        }
    )
    tag_id = SelectField(
        label="tag",
        validators=[
            DataRequired("please select tag")
        ],
        coerce=int,
        choices=[(v.id,v.name) for v in Tag.query.all()],
        description="tag",
        render_kw={
            "class": "form-control",
        }
    )
    area = StringField(
        label="place",
        validators=[
            DataRequired(" please input the place")],
        description="place",
        render_kw={

            "class": "form-control",
            "placeholder": "请输入diqu！",
        }

    )
    length = StringField(
        label="movie length",
        validators=[
            DataRequired(" please input the length")],
        description="movie length",
        render_kw={

            "class": "form-control",
            "placeholder": "请输入movie length！",
        }

    )
    release_time = StringField(
        label="release time",
        validators=[
            DataRequired(" please select the release time")],
        description="time of release",
        render_kw={

            "class": "form-control",
            "placeholder": "请select movie release time！",
            "id": "input_release_time"
        }
    )
    submit = SubmitField(
        "edit",
        render_kw={
            "class": "btn btn-primary"
        }
    )

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



