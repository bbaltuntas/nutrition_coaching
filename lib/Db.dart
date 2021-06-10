import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'login.dart';

class DatabaseHelper {

  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final Users_table = 'Users';
  static final Customer_table = 'Customer';
  static final Dietitian_table = 'Dietitian';
  static final Hospital_table = 'Hospital';
  static final Address_table = 'Address';
  static final Experience_table = 'Experience';
  static final Appointment_table = 'Appointment';
  static final DailyData_table = 'DailyData';
  static final Exercise_table = 'Exercise';
  static final Nutrition_table = 'Nutrition';
  static final Food_table = 'Food';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $Users_table (
          user_id	 		INTEGER PRIMARY KEY,
        	u_name			TEXT NOT NULL,
          u_surname		TEXT NOT NULL,
          birth_date		TEXT not null,
          Gender			NUMERIC not null,
          password     TEXT not null,
          isDietitian  NUMERIC not null
          )
          ''');
    await db.execute('''
          CREATE TABLE $Customer_table (
          customer_id	   INTEGER not null,
	        Weight				 INTEGER not null,
          Height				 INTEGER not null
          )
          ''');
    await db.execute("""
    create table $Hospital_table
      (	hospital_id			INTEGER not null PRIMARY KEY,
        hospital_name		Text not null,
        Available_hours		text not null
      )
    """);
    await db.execute('''
          CREATE TABLE $Dietitian_table (
          dietatian_id		INTEGER not null,
          room_number			INTEGER not null,
          hospital_id 		INTEGER not null,
          foreign key (hospital_id) references Hospital(hospital_id)
          )
          ''');
    await db.execute('''
          CREATE TABLE $Address_table (
            district_name		varchar(50) not null,
            city_name			varchar(20) not null,
            zip_code			varchar(10),
            user_id				INTEGER not null,
            foreign key (user_id) references Users(user_id)
          )
          ''');
    await db.execute('''
          CREATE TABLE $Experience_table (
            exp_place 			varchar(50) not null,
            exp_field			varchar(50) not null,
            exp_duration		INTEGER not null,
            dietatian_id		INTEGER,
            foreign key (dietatian_id) references Dietatian(dietatian_id)
          )
          ''');
    await db.execute('''
          CREATE TABLE $Appointment_table (
              dietatian_id		INTEGER,
              customer_id			INTEGER,
              a_date				TEXT,
             foreign key (dietatian_id) references Dietatian(dietatian_id),
             foreign key (customer_id) references Customer(customer_id)
          )
          ''');
    await db.execute('''
          CREATE TABLE $DailyData_table (
              dailydata_id INTEGER not null PRIMARY KEY,
              customer_id			INTEGER,
              TIMESTAMP dd_timestamp DEFAULT CURRENT_TIMESTAMP,
              foreign key (customer_id) references Customer(customer_id)
          )
          ''');
    await db.execute('''
          CREATE TABLE $Exercise_table (
             exercise_name			TEXT not null,
              e_type			 		 TEXT not null,
              Duration 				INTEGER not null,
              calories_burned			INTEGER not null,
              dailydata_id 			INTEGER not null,
              foreign key (dailydata_id) references DailyData(dailydata_id)
          )
          ''');
    await db.execute('''
          CREATE TABLE $Nutrition_table (
              food_name varchar(20) not null PRIMARY KEY,
              fat					INTEGER not null,
              carbohydrate		INTEGER not null,
              protein				INTEGER not null
          )
          ''');
    await db.execute('''
          CREATE TABLE $Food_table (
                dailydata_id	 		INTEGER not null,
                food_name			varchar(20) not null,
                quantity			varchar(50) not null,
                foreign key (dailydata_id) references DailyData(dailydata_id),
                foreign key (food_name) references Nutrition(food_name)
          )
          ''');
  }

  // Helper methods
  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row,String tableName) async {
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }


  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows(String tableName) async {
    Database db = await instance.database;
    return await db.query(tableName);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount(table) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<bool> find(var element, String tableName, String columName) async {
    Database db = await instance.database;
    var result= await db.query(tableName,where: '$columName = ?',whereArgs: [element]);

    if(result.length==0){
      return true;
    }else{
      return false;
    }
  }


  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row,String tableName, columnId) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(tableName, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id,String tableName, columnId) async {
    Database db = await instance.database;
    var data_id = await db.query(tableName,where: '$columnId = ?',whereArgs: [id]);
    await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
    return data_id[0][columnId];
  }

  Future<void> deleteAll(String tableName) async {
    Database db = await instance.database;
    await db.delete(tableName);
  }

  /*Future<void> addAllToDB(String tableName,List<dynamic> list) async {
    Database db = await instance.database;
    HomeScreen.favoList=[];
    for(int i=0;i<list.length;i++){
      Map<String, dynamic> row =list[i];
      HomeScreen.favoList.add(row);
      insert(row, tableName);
    }
  }*/

/*DATABASE INSERTION*/
/*  void _insert(String title, String Movie_id, String overview,
      String poster_path, String tableName) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnMovieID: Movie_id,
      DatabaseHelper.columnTitle: title,
      DatabaseHelper.columnOverview: overview,
      DatabaseHelper.columnPoster: poster_path,
    };
    final id = await dbHelper.insert(row, tableName);
  }
*/

static InitInserts() async{
  Database db = await instance.database;
  if (Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(user_id) FROM Users')) == 0){
    db.rawInsert('INSERT INTO $Users_table(u_name, u_surname, birth_date, Gender, password, isDietitian )'
        ' VALUES("Kerem", "Coskun","01-03-2000",1,"12345",0),("Seda", "Demirayak", "2000-01-02", 0,"12345",0), ("Bora", "Altuntaş", "1995-04-06", 1,"12345",0), ("Metehan", "Arık", "1997-07-09", 1,"12345",0) ');
    db.rawInsert('INSERT INTO $Users_table(u_name, u_surname, birth_date, Gender, password, isDietitian ) VALUES("Ali", "Portakal", "1965-01-05", 1,"12345",1), ("Ayşe", "Gözen", "1989-04-09", 0,"12345",1),  ("Emrullah","Dağ", "1990-02-07", 1,"12345",1)');
    db.rawInsert('''INSERT INTO $Address_table( district_name, city_name	, zip_code, user_id ) 
    VALUES
    ("Zafer Mah. 15 temmuz Sok.", "Kayseri", "38000",  1),
    ("Ertuğrul Gazi mah. Aktaş Sok.", "Bursa", "16000",  2),
    ("Cumhuriyet Mah. Yeşilçarşaf Sok.", "Kayseri", "38000",  3),
    ("Yurt Mah. Abdi İpekçi Sok.", "Adana", "01000",  4),
    ("Ertuğrul Gazi mah. Aktaş Sok.", "Bursa", "16000", 5),
    ("Cumhuriyet Mah. Yeşilçarşaf Sok.", "Kayseri", "38000", 6),
    ("Zafer Mah. 15 temmuz Sok.", "Kayseri", "38000", 7)''');
    db.rawInsert('''INSERT INTO $Customer_table( customer_id, Weight, Height) 
     VALUES
      (1,56,1.70),
      (2, 65, 1.85),
      (3, 62, 1.90),
      (4, 90, 1.55)
     ''');
    db.rawInsert('''INSERT INTO $Hospital_table( hospital_name, Available_hours) 
     VALUES
       ("Tekden", "7.00/22.00"),
       ("Kayseri Devlet Hastanesi", "8.00/19.00")
     ''');
    db.rawInsert('''INSERT INTO $Dietitian_table( dietatian_id, room_number, hospital_id) 
     VALUES
        (5,12,1),
        (6,25,1),
        (7,32,2)
     ''');
    db.rawInsert('''INSERT INTO $Experience_table( exp_place, exp_field, exp_duration, dietatian_id) 
     VALUES
        ("Abdullah Gul University", "Fitness Dietatian", 4, 5),    
        ("Bosphorus University", "Pediatric Dietatian", 4, 6),    
        ("METU", "Chief Dietatian", 4, 7)
     ''');

  db.rawInsert('''INSERT INTO $Appointment_table (dietatian_id, customer_id, a_date)
     VALUES
      (5, 1, "17-05-2021 17:00"),
      (6, 3,  "17-05-2021 16:00")
     ''');
  db.rawInsert('''INSERT INTO $DailyData_table (customer_id)
     VALUES
        (1 ),
        (2 ),
        (3 ),
        (4)
     ''');

  db.rawInsert('''INSERT INTO $Exercise_table (exercise_name, e_type, Duration , calories_burned, dailydata_id)
     VALUES
        ("Walking","slow", 90, 100,1),
        ("Walking","normal",20,25,2),
        ("Walking","fast",24,95,3),
        ("Trekking","slow",35,45,1),
        ("Trekking","normal",64,120,2),
        ("Trekking","fast",100,200,3)
     ''');
  db.rawInsert('''INSERT INTO $Nutrition_table (food_name, fat, carbohydrate, protein)
     VALUES
       ("Bean", 16,85,36),
      ("Milk", 25,45,20),
      ("Brocoli", 2,15,12),
      ("Meat", 26,45,2)
     ''');
    db.rawInsert('''INSERT INTO $Food_table(dailydata_id, food_name, quantity)
     VALUES
      (1, "Meat", 250),
      (1,"Milk", 200),
      (1, "Brocoli", 150),  
      (2, "Meat", 400),
      (2,"Milk", 200),
      (2, "Bean", 150)
     ''');
  }





}



}