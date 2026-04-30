import mariadb


def hentedata():
    conn = None  # ✅ Initialiser først
    try:
        conn = mariadb.connect(  # ✅ Ikke bruk "with", bare vanlig connect
            user="axel",
            password="passord",
            host="localhost",
            port=3306,
            database="flaskeDB"
        )
        mycursor = conn.cursor()
        mycursor.execute("SELECT * FROM flasketyper")
        return mycursor.fetchall()

    except mariadb.Error as e:
        print(f"Error connecting to MariaDB Platform: {e}")
        return []

    finally:
        if conn:  # ✅ Sjekker at conn faktisk eksisterer før close()
            conn.close()