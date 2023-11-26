db.createCollection("Answers")

// Задание 1
db.Answers.insertOne({"1" : db.Students.createIndex({"Номер":1}, {unique:true})});

// Задание 2
db.Answers.insertOne({"2": db.Students.stats()});

// Задание 3
db.Answers.insertOne({"3": db.Students.countDocuments()});

// Задание 4
db.Answers.insertOne({"4": db.Students.count({"Специальность": "Математика"})});

// Задание 5
db.Answers.insertOne({"5": db.Students.count({"Специальность": "Математика", "Курс": 2})});

// Задание 6
db.Answers.insertOne({"6": db.Students.count({"Специальность": "Математика", "Курс": {$ne: 2}})});

// Задание 7
db.Answers.insertOne({"7": db.Students.count({"Специальность": "Математика", "Курс": {$gt: 3}})});

// Задание 8
db.Answers.insertOne({"8": db.Students.count({$or: [{ "Специальность": "Юриспруденция" },
 { "Специальность": "Экономика" }],
 "Курс": { $ne: 3 } })});

// Задание 9
db.Answers.insertOne({"9": db.Students.distinct("Гражданство").length});

// Задание 10
db.Answers.insertOne({"10": db.Students.find({}, {"_id": 1, "Факультет": 1, "Гражданство": 1}).sort({ "Гражданство": 1 }).limit(10).toArray()});

// Задание 11
// mongoimport --jsonArray --db University --collection Languages2 --file /home/prianechka/nosql/Languages2.json

// Задание 12
db.Answers.insertOne({"12": db.Students.aggregate([
    {
        $lookup:{
            from: "Languages2",       // other table name
            localField: "idLanguage",   // name of users table field
            foreignField: "_id", // name of userinfo table field
            as: "languages2"         // alias for userinfo table
        }
    },
    {$unwind:"$languages2"},
    {
        $match:{
            $and:[{"Номер" : "1032102469"}]
        }
    },
    {
        $project:{
            languages : "$languages2.Languages"
        }
    }
]).toArray()});


// Задание 13
db.Answers.insertOne({"13": db.Students.find({ "idLanguage": { $ne: null } }).count()});

// Задание 14
db.Answers.insertOne({"14": db.Students.find({"idLanguage":  null}).count()});

// Задание 15
db.Answers.insertOne({"15": db.Students.aggregate([
    {
        $lookup:{
            from: "Languages2",       // other table name
            localField: "idLanguage",   // name of users table field
            foreignField: "_id", // name of userinfo table field
            as: "languages2"         // alias for userinfo table
        }
    },
    {$unwind:"$languages2"},
    {
        $match:{
            $and:[{"languages2.Languages" : {$in : ["немецкий"]}}]
        }
    }
]).toArray().length});
