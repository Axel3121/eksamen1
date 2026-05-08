from flask import Flask, render_template, jsonify, request
import mariadb

app = Flask(__name__)

def get_db():
    return mariadb.connect(
        user="axel",
        password="passord",
        host="localhost",
        port=3306,
        database="flaskeDB"
    )
@app.route('/')
def hello_world():
    return render_template("flasker.html")

# Hent topp 10 highscores
@app.route('/api/highscore', methods=['GET'])
def get_highscore():
    db = get_db()
    cursor = db.cursor()
    cursor.execute("SELECT spillernavn, poeng, tid_sekunder, dato FROM highscores ORDER BY poeng DESC LIMIT 10")
    result = []
    for rad in cursor.fetchall():
        result.append({
            "spillernavn": rad[0],
            "poeng": rad[1],
            "tid": float(rad[2]),
            "dato": str(rad[3])
        })
    return jsonify(result)

# Lagre ny highscore fra Godot
@app.route('/api/highscore', methods=['POST'])
def save_highscore():
    data = request.json
    db = get_db()
    cursor = db.cursor()
    cursor.execute(
        "INSERT INTO highscores (spillernavn, poeng, tid_sekunder) VALUES (?, ?, ?)",
        (data["spillernavn"], data["poeng"], data["tid"])
    )
    db.commit()
    return jsonify({"status": "ok"})

# Nedlasting av spillet
@app.route('/last-ned')
def last_ned():
    return render_template("last_ned.html")

if __name__ == '__main__':
    app.run(debug=True)