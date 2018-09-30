#coding:utf8
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
import os
app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = "mysql+pymysql://b84a550e7f719b:c51a034d@us-cdbr-iron-east-01.cleardb.net/heroku_91504066c035296"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
app.config['SECRET_KEY']='3c23b72940404fcdb463476d5fb3c0da'
app.config['UP_DIR']=os.path.join(os.path.abspath(os.path.dirname(__file__)),"static/uploads/")
app.config['FC_DIR']=os.path.join(os.path.abspath(os.path.dirname(__file__)),"static/uploads/users/")
app.debug=False
db = SQLAlchemy(app)

from app.home import home as home_blueprint
from app.admin import admin as admin_blueprint

app.register_blueprint(home_blueprint)
app.register_blueprint(admin_blueprint,url_prefix="/admin")
