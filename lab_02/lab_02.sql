db.createCollection("Students", {
  validator: {
    $and: [ {"Номер": {$type: "string", $exists: true}}]}});

db.Students.createIndex({"Номер":1}, {unique:true});

db.createCollection("Answers")

// mongoimport --jsonArray --db University --collection Students --file /home/prianechka/nosql/Students.json --maintainInsertionOrder
// mongoimport --jsonArray --db University --collection Languages2 --file /home/prianechka/nosql/Languages2.json


// Задание 1.1
db.Answers.insertOne({"1.1":
    db.Students.find({$and: [{"Специальность": {$nin: ["Юриспруденция", "Экономика"]}}, {"Статус": "Обучение"}]}).count()
});

// Задание 1.2
db.Answers.insertOne({"1.2":
    db.Students.find(
    {$or: [
    {$and: [{"Специальность": "Математика"}, {"Курс": "1"}, {"Статус": "Обучение"}]},
    {$and: [{"Специальность": "Экономика"}, {"Курс": {$ne: "3"}}, {"Статус": "Обучение"}]},
    ]}).count()
});

// Задание 1.3
var list_of_france_language = db.Languages2.distinct("_id", {"Languages": {$in: ["французский"]}}).valueOf();

db.Answers.insertOne({"1.3":
    db.Students.find(
        {$and: [
        {"Статус": "Обучение"},
        {$or: [
            {$and: [{"Специальность": "Юриспруденция"}, {"Гражданство": "Российская Федерация"}]},
            {$and: [{"Гражданство": {$ne: "Российская Федерация"}},
                    {"idLanguage" : {$nin: list_of_france_language}},
            ]}
        ]}]}).count()
});

// Задание 2.1
db.Answers.insertOne({"2.1":
    db.Students.aggregate([{$group:{_id:"$Форма обучения",count:{$sum:1}}}]).toArray()
});

// Задание 2.2
db.Answers.insertOne({"2.2":
    db.Students.aggregate([
    {$match: {"Статус": "Завершение"}},
    {$group:
        {_id:"$Факультет", count:  {$sum: 1}}
    }]).toArray()
});

// Задание 2.3
db.Answers.insertOne({"2.3":
    db.Students.aggregate([
    {$match: {$and: [{"Курс": 2}, {"Факультет": "Юридический"}, {"Статус": "Обучение"}]}},
    {$group:
        {_id:"$Специальность", count:  {$sum: 1}}
    }]).toArray()
});

// Задание 2.4
db.Answers.insertOne({"2.4":
    db.Students.aggregate([
    {$match: {$and: [{"Факультет": "Экономический"}, {"Статус": "Отчисление"}]}},
    {$group: {_id: "Средний курс", avgCourse: { $avg: "$Курс" }}}
    ]).toArray()
});

// Задание 2.5
db.Answers.insertOne({"2.5":
    db.Students.aggregate([
    {$match: {"Статус": "Отчисление"}},
    {$group: {_id: "$Факультет", minCourse: { $min: "$Курс" }}}
    ]).toArray()
});

// Задание 3.1
db.Answers.insertOne({"3.1":
    db.Students.aggregate([{$group:{_id:"$Форма обучения",count:{$sum:1}}}]).toArray()
});

// Задание 3.2
db.Answers.insertOne({"3.2":
    db.Students.aggregate([
    {$match: {"Статус": "Завершение"}},
    {$group:
        {_id:"$Факультет", count:  {$sum: 1}}
    }]).toArray()
});

// Задание 3.3
db.Answers.insertOne({"3.3":
    db.Students.aggregate([
    {$match: {$and: [{"Курс": 2}, {"Факультет": "Юридический"}, {"Статус": "Обучение"}]}},
    {$group:
        {_id:"$Специальность", count:  {$sum: 1}}
    }]).toArray()
});

// Задание 3.4
db.Answers.insertOne({"3.4":
    db.Students.aggregate([
    {$match: {$and: [{"Факультет": "Экономический"}, {"Статус": "Отчисление"}]}},
    {$group: {_id: "Средний курс", avgCourse: { $avg: "$Курс" }}}
    ]).toArray()
});

// Задание 3.5
db.Answers.insertOne({"3.5":
    db.Students.aggregate([
    {$match: {"Статус": "Отчисление"}},
    {$group: {_id: "$Факультет", minCourse: { $min: "$Курс" }}}
    ]).toArray()
});
});

// Задание 3.5
db.Answers.insertOne({"3.5":
    db.Students.aggregate([
    {$match: {"Статус": "Отчисление"}},
    {$group: {_id: "$Факультет", minCourse: { $min: "$Курс" }}}
    ]).toArray()
});
