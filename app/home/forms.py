from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField, FileField, TextAreaField
from wtforms.validators import DataRequired, Email, Regexp, EqualTo, ValidationError, Length
from app.models import User


class RegistForm(FlaskForm):
    email = StringField(
        label="Email",
        validators=[
            DataRequired("邮箱不能为空！"),
            Email("邮箱格式不正确！")
        ],
        description="email",
        render_kw={
            "class": "form-control input-lg",
            "placeholder": "Your email *",
            "style": "border-radius: 1.5rem",
        }
    )

    pwd = PasswordField(
        label="Password",
        validators=[
            DataRequired("密码不能为空！")
        ],
        description="密码",
        render_kw={
            "class": "form-control input-lg",
            "placeholder": " the password！",
            "style": "border-radius: 1.5rem"
        }
    )
    repwd = PasswordField(
        label="Comfirm password",
        validators=[
            DataRequired("请输入确认密码！"),
            EqualTo('pwd', message="两次密码不一致！")
        ],
        description="comfirm password",
        render_kw={
            "class": "form-control input-lg",
            "placeholder": "请输入确认密码！",
            "style": "border-radius: 1.5rem;"
        }
    )
    submit = SubmitField(
        'Login',
        render_kw={
            "class": "btn btn-lg btn-light btn-block",
            "style": "border-radius: 1.5rem;color:#4d4d4d"
        }
    )


    def validate_email(self, field):
        email = field.data
        user = User.query.filter_by(email=email).count()
        if user == 1:
            raise ValidationError("Email Already Exist！")



class LoginForm(FlaskForm):
    email = StringField(
        label="email",
        validators=[
            DataRequired("账号不能为空！")
        ],
        description="email",
        render_kw={
            "class": "form-control input-lg",
            "placeholder": "Your Email * ",
            "style": "border-radius: 0.5rem;"
        }
    )
    pwd = PasswordField(
        label="Password",
        validators=[
            DataRequired("密码不能为空！")
        ],
        description="password",
        render_kw={
            "class": "form-control input-lg",
            "placeholder": "Your password * ",
            "style": "border-radius: 0.5rem;"
        }
    )
    submit = SubmitField(
        'Login',
        render_kw={
            "class": "btn btn-lg btn-light btn-block",
            "style":"border-radius: 1.5rem;"
        }
    )


class UserdetailForm(FlaskForm):

    email = StringField(
        label="email",
        validators=[
            DataRequired("邮箱不能为空！"),
            Email("邮箱格式不正确！")
        ],
        description="邮箱",
        render_kw={
            "class": "form-control",
            "placeholder": "请输入邮箱！",
        }
    )

    face = FileField(
        label="头像",
        validators=[
            DataRequired("请上传头像！")
        ],
        description="头像",
    )
    info = TextAreaField(
        label="简介",
        validators=[
            DataRequired("简介不能为空！")
        ],
        description="简介",
        render_kw={
            "class": "form-control",
            "rows": 10
        }
    )
    submit = SubmitField(
        'Done',
        render_kw={
            "class": "btn btn-light",
            "style": "border-radius: 1.5rem;"
        }
    )


class PwdForm(FlaskForm):
    old_pwd = PasswordField(
        label="Old Password",
        validators=[
            DataRequired("旧密码不能为空！")
        ],
        description="Old pwd",
        render_kw={
            "class": "form-control",
            "placeholder": "Please Input the Old Password！",
        }
    )
    new_pwd = PasswordField(
        label="New Password",
        validators=[
            DataRequired("新密码不能为空！"),
        ],
        description="new pwd",
        render_kw={
            "class": "form-control",
            "placeholder": "Please Input the New Password！",
        }
    )
    submit = SubmitField(
        '修改密码',
        render_kw={
            "class": "btn btn-light",
            "style": "border-radius: 1.5rem;"
        }
    )

class CommentForm(FlaskForm):
    content = TextAreaField(
        label="内容",
        validators=[
            DataRequired("请输入内容！"),
        ],
        description="内容",
        render_kw={
            "id": "input_content"
        }
    )
    submit = SubmitField(
        '提交评论',
        render_kw={
            "class": "btn btn-success",
            "id": "btn-sub"
        }
    )