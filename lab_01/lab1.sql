createCollection("Students", {
  validator: {
    $and: [ {"Номер": {$type: "string", $exists: true}}]}});
db.Students.createIndex({"Номер":1}, {unique:true});

db.createCollection("Answers")

// mongoimport --jsonArray --db University --collection Students --file /home/prianechka/nosql/Students.json --maintainInsertionOrder

// Задание 2
db.Answers.insertOne({"2": db.Students.stats().count});

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
            from: "Languages2",
            localField: "idLanguage",
            foreignField: "_id",
            as: "languages2"
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
            from: "Languages2",
            localField: "idLanguage",
            foreignField: "_id",
            as: "languages2"
        }
    },
    {$unwind:"$languages2"},
    {
        $match:{
            $and:[{"languages2.Languages" : {$in : ["немецкий"]}}]
        }
    }
]).toArray().length});

// Задание 16
db.Answers.insertOne({"16": db.Languages2.find({Languages: { $size: 3 }}, {"_id": 1}).toArray()});

// Задание 17
db.Answers.insertOne({"17": db.Students.aggregate([
    {
        $lookup:{
            from: "Languages2",
            localField: "idLanguage",
            foreignField: "_id",
            as: "languages2"
        }
    },
    {$unwind:"$languages2"},
    {
        $match:{
            $and:[{"languages2.Languages" : {$size: 3}}]
        }
    }
]).toArray().length});

// Задание 18
db.Answers.insertOne({"18": db.Students.aggregate([
    {
        $lookup:{
            from: "Languages2",
            localField: "idLanguage",
            foreignField: "_id",
            as: "languages2"
        }
    },
    {$unwind:"$languages2"},
    {
        $match:{
            $and:[{"languages2.Languages" : {$size: 5}}]
        }
    }
]).toArray().length});

// Задание 19
db.Students.createIndex({"Гражданство": 1});
db.Students.createIndex({"Период": -1});
db.Students.createIndex({"Пол": 1, "Специальность": -1})

// Задание 20
db.Students.updateMany({"Курс": {$ne: 6}}, { $inc: {"Курс": 1}});
db.Students.updateMany({"Курс": {$gt: 6}}, { $set: {"Курс": 6}});
db.Answers.insertOne({"20": db.Students.find({}).sort({"_id": 1}).skip(499).limit(1501).toArray()});

// Задание 21
db.Answers.insertOne({"21": db.Students.find({"Номер": {$regex: /(\d{3})(209)(\d{4})/}}).toArray().length});

// Задание 22
db.Answers.insertOne({"22": db.Students.find({"Номер": {$regex: /^(\d{3})(20[0-5])(\d*)/}}).toArray().length});

// Задание 23
db.createCollection("Students2", {
  validator: {
    $and: [ {"Номер": {$type: "string", $exists: true}}]}});
db.Students2.createIndex({"Номер":1}, {unique:true});

// mongoimport --jsonArray --db University --collection Students2 --file /home/prianechka/nosql/Students2.json --maintainInsertionOrder


db.Answers.insertOne({"23": db.Students2.aggregate([
  {
    $group: {
      _id: { $type: "$Курс" },
      count: { $sum: 1 }
    }
  }
]).toArray()});

// Задание 24
db.Answers.insertOne({"24": db.Students.aggregate([
    {
        $sort: {"_id": 1}
    },
    {
        $lookup:{
            from: "Languages2",
            localField: "idLanguage",
            foreignField: "_id",
            as: "Languages"
        }
    },
    {
        $skip: 98
    },
    {
        $limit: 101
    }
]).toArray()});
