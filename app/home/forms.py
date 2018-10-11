from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField, FileField, TextAreaField
from wtforms.validators import DataRequired, Email, Regexp, EqualTo, ValidationError, Length
from app.models import User


class RegistForm(FlaskForm):
    email = StringField(
        label="Email",
        validators=[
            DataRequired("Enter the Email！"),
            Email("Email Must Match！")
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
            DataRequired("Enter Your Password！")
        ],
        description="Password",
        render_kw={
            "class": "form-control input-lg",
            "placeholder": " the password！",
            "style": "border-radius: 1.5rem"
        }
    )
    repwd = PasswordField(
        label="Confirm The Password",
        validators=[
            DataRequired("Confirm the Passwords！"),
            EqualTo('pwd', message="Passowrd Must Match！")
        ],
        description="comfirm password",
        render_kw={
            "class": "form-control input-lg",
            "placeholder": "Confirm The password！",
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
            DataRequired("Enter your email！")
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
            DataRequired("Enter your password！")
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
            DataRequired("Enter your password"),
            Email("Passwords must match")
        ],
        description="Email",
        render_kw={
            "class": "form-control",
            "placeholder": "Your Email *",
        }
    )

    face = FileField(
        label="Face",
        validators=[
            DataRequired("Upload Your Selfie")
        ],
        description="Selfie",
    )
    info = TextAreaField(
        label="Description",
        validators=[
            DataRequired("Enter your Description")
        ],
        description="info",
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
            DataRequired("Enter the Old Password！")
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
            DataRequired("Enter Your New Password"),
        ],
        description="new pwd",
        render_kw={
            "class": "form-control",
            "placeholder": "Please Input the New Password！",
        }
    )
    submit = SubmitField(
        'Change The Password',
        render_kw={
            "class": "btn btn-light",
            "style": "border-radius: 1.5rem;"
        }
    )

class CommentForm(FlaskForm):
    content = TextAreaField(
        label="Review",
        validators=[
            DataRequired("Type in the Review！"),
        ],
        description="Review",
        render_kw={
            "id": "input_content"
        }
    )
    submit = SubmitField(
        'Submit',
        render_kw={
            "class": "btn btn-success",
            "id": "btn-sub"
        }
    )