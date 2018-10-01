form app import db
from app.models import Admin, Movie,User,Comment,Moviecol,Auth,Role,Oplog, Adminlog, Userlog


db.create_all()

print("DB created.")
