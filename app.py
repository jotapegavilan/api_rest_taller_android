from flask import Flask,jsonify,request
from flask_jwt_extended import JWTManager, jwt_required, create_access_token
import bcrypt
from datetime import timedelta
from models import db,usuarios,categorias,proyectos,lenguajes

app = Flask(__name__)
#app.config['JSON_AS_ASCII'] = False
app.config["SQLALCHEMY_DATABASE_URI"] = "mysql+pymysql://root:@localhost/taller_android"
app.config["JWT_SECRET_KEY"] = 'taller_android_st'
app.config["JWT_ACCESS_TOKEN_EXPIRES"] = timedelta(minutes=60)

db.init_app(app)


jwt = JWTManager(app)


def existe(llave, dicc):
    return llave in dicc

@app.route('/api/sign_up', methods=['POST'])

def sign_up():   
    try:            
        user_json = request.get_json()
        if( usuarios.query.filter_by(email=user_json["email"]).first() != None ):
            return jsonify({"msg":user_json["email"]+" YA EXISTE EN NUESTROS REGISTROS."})
        user = usuarios()
        if existe('nombres',user_json):
            user.nombres = user_json['nombres']
        else:
            return jsonify({"msg":'No se envio el campo nombres'}),400
        if existe('apellidos',user_json):
            user.apellidos = user_json['apellidos']
        else:
            return jsonify({"msg":'No se envio el campo apellidos'})
        if existe('email',user_json):
            user.email = user_json['email']
        else:
            return jsonify({"msg":'No se envio el campo email'})
        if existe('rol',user_json):
            user.rol = user_json['rol']
        else:
            return jsonify({"msg":'No se envio el campo email'})
        if existe('clave',user_json):
            password = user_json['clave'].encode('utf-8')
            print(password)
            if len(password) < 6:
                return jsonify({"msg":'El password debe tener min. 6 caracteres'})
        else:
            return jsonify({"msg":'No se envio el campo clave'})
        
        user.clave = bcrypt.hashpw(password=password,salt=bcrypt.gensalt())      
        clave = user.clave
        user.clave = user.clave.decode('utf-8')  

        db.session.add(user)        
        db.session.commit()        
        
        return jsonify({"msg":"Usuario registrado correctamente"})
    except Exception as ex:
        print(ex)
        return jsonify({"msg":ex}),500

@app.route('/api/sign_in', methods=['POST'])
def sign_in():
    try:
        #save_db()
        if request.get_json() != None:            
            login_json = request.get_json()
            if existe('email',login_json):
                username = login_json['email']
            else:
                return jsonify({"msg":'No se envio el campo email'})
            if existe('clave',login_json):
                password = login_json['clave'].encode('utf-8')
                
            else:
                return jsonify({"msg":'No se envio el campo clave'})      
            user = usuarios.query.filter_by(email=username).first()
            
            if(user == None):
                return jsonify({"msg":"El usuario no existe"})            
            if bcrypt.checkpw(password,user.getClave()): 
                access_token = create_access_token(identity=username,additional_claims={"rol":user.rol,"id":user.id})  
                user.token = access_token
                return jsonify({"msg":"ok","user":user.serialize()})
            else:
                return jsonify({"msg":"La contraseña es incorrecta"})
        else:
                return jsonify({"msg":"No se envio un json"})
    except Exception as ex:
        return jsonify({"msg":ex}),500




@app.route("/api/usuarios")
def get_users():
    users = usuarios.query.order_by(usuarios.id.desc()).limit(10).all()
    toReturn = [u.serialize() for u in users]
    return jsonify(toReturn),200

@app.route("/api/lenguajes")
def get_lenguajes():
    leng = lenguajes.query.order_by(lenguajes.id.asc()).limit(10).all()
    toReturn = [l.serialize() for l in leng]
    return jsonify(toReturn),200

@app.route("/api/categorias")
def get_categories():
    categories = categorias.query.order_by(categorias.id.asc()).limit(10).all()
    toReturn = [c.serialize() for c in categories]
    return jsonify(toReturn),200

@app.route("/api/categorias",methods=['POST'])
def add_categorie():
    request_data = request.get_json()
    cat = categorias()
    cat.nombre = request_data["nombre"]
    cat.color = request_data["color"]
    db.session.add(cat)
    db.session.commit()
    return jsonify({"msg":cat.serialize()}),200

@app.route("/api/proyectos/<int:id>")
@jwt_required()
def get_proyectos(id):
    projects = proyectos.query.filter_by(usuario_id=id).order_by(proyectos.id.desc()).all()
    toReturn = [p.serialize() for p in projects]
    return jsonify(toReturn),200


@app.route("/api/proyectos/<int:id>",methods=["DELETE"])
def delete_proyecto(id):
    print(id)
    project = proyectos.query.get(id)  
    print(project)
    if(project == None):
        return jsonify({"msg":"no existe"})
    db.session.delete(project)
    db.session.commit()  
    return jsonify({"msg":"ok"})

@app.route("/api/proyectos",methods=["POST"])
def add_proyecto():
    request_data = request.get_json()
    pro = proyectos()
    pro.nombre = request_data["nombre"]
    pro.descripcion = request_data["descripcion"]
    pro.usuario_id = request_data["usuario_id"]
    pro.categoria_id = request_data["categoria_id"]
    pro.lenguaje_id = request_data["lenguaje_id"]
    db.session.add(pro)
    db.session.commit()
    return jsonify(pro.serialize()),200

@app.route("/api/proyectos", methods=["PUT"])
def update_proyect():
    request_data = request.get_json()
    pro = proyectos()
    pro.nombre = request_data["nombre"]
    pro.descripcion = request_data["descripcion"]
    pro.usuario_id = request_data["usuario_id"]
    pro.categoria_id = request_data["categoria_id"]
    pro.fecha_fin = request_data["fecha_fin"]
    pro.lenguaje_id = request_data["lenguaje_id"]
    proyectos.query.filter_by(id=request_data["id"]).update(pro)
    db.session.commit()
    return jsonify({"msg":pro.serialize()}),200

if __name__ == "__main__":
    app.run(debug=True,port=4000,host='0.0.0.0')