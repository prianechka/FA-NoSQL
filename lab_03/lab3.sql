db.createCollection("Answers")

// mongoimport --jsonArray --db University --collection Students --file /home/prianechka/nosql/Students.json --maintainInsertionOrder
// mongoimport --jsonArray --db University --collection Languages2 --file /home/prianechka/nosql/Languages2.json

// Задание 1
// mongoimport --jsonArray --db University --collection Kladr --file /home/prianechka/nosql_3/kladr7.json --maintainInsertionOrder

// Задание 2
// Сколько уровней адресов в КЛАДРе?
db.Answers.insertOne({"2":
    db.Kladr.aggregate([{$group:{_id:"$details.level"}}]).toArray().length
});

// Задание 3
// Перечислите наименование уровней.
db.Answers.insertOne({"3":
    db.Kladr.aggregate([
        {$group:{_id: {level: "$details.level", level_name: "$details.type"}}},
        { $sort: {"_id.level": 1} }]).toArray()
});

// Задание 4
// Сколько объектов в каждом уровне?
db.Answers.insertOne({"4":
    db.Kladr.aggregate([
        {$group:{_id:"$details.level", count:{$sum:1}}},
        { $sort: {"_id": 1} }]).toArray()
});

// Задание 5
// Составьте перечень типов населенных пунктов.
db.Answers.insertOne({"5":
    db.Kladr.aggregate([
        {$group:{_id: {level: "$details.level", level_name: "$details.type"}}},
        { $sort: {"_id.level": 1} }]).toArray()
});

// Задание 6
// Сколько населенных пунктов начинается на букву М?
db.Answers.insertOne({"6":
    db.Kladr.find({"details.name": {$regex: /^М/}}).toArray().length
});

// Задание 7
// Сколько населенных пунктов начинается на каждую букву?
db.Answers.insertOne({"7":
    db.Kladr.aggregate([
    {$match: {"details.name": {$regex: /^[А-Я0-9]/ }}},
    {$group: {_id: {$substrCP: ['$details.name', 0, 1]}, count: {$sum: 1}}},
    { $sort: {"count": -1} },
    ]).toArray()
});

// Задание 8
// Какое назначение ключа district? -- Это округ

// Задание 9
// Какое количество объектов у каждого значения district?
db.Answers.insertOne({"9":
    db.Kladr.aggregate([
        {$group:{_id:"$details.district", count:{$sum:1}}},
        { $sort: {"count": 1} }]).toArray()
});

// Задание 10
// Задание 10.1
var cursor = db.Kladr.find({"details.level": 4},
{
    "_id": 1,
    "type": "$details.type",
    "name": "$details.name"
}).limit(100);

// Задание 10.2
db.createCollection("NewCollection")
while (cursor.hasNext()) {
    db.NewCollection.insertOne(cursor.next());
}
db.Answers.insertOne({"10.2":
    db.NewCollection.find({}).toArray()
});

// Задание 10.3
var cursor2 = db.Kladr.find({"details.level": 4},
{
    "_id": 1,
    "type": "$details.type",
    "name": "$details.name"
}).limit(100);

arr = cursor2.toArray()

// Задание 10.4
db.createCollection("NewCollection2")
db.NewCollection2.insertMany(arr)

db.Answers.insertOne({"10.4":
    db.NewCollection2.find({}).toArray()
});

// Задание 10.5
db.createCollection("NewCollection3")
var cursor3 = db.Kladr.find({"details.level": 4, "details.district": "Центральный"}).skip(199).limit(101)
arr3 = cursor3.toArray()
db.NewCollection3.insertMany(arr3)

db.Answers.insertOne({"10.5":
    db.NewCollection3.find({}).toArray()
});

// Задание 11
// Создайте индекс по ключу wikiname.
db.Kladr.createIndex({"details.region.wikiname": 1});

// Задание 12
// Создайте уникальный индекс по ключу name населенного пункта. Какой будет результат?
db.Kladr.createIndex({"details.name": 1}, {unique: true});

// Падает с ошибкой
// Write failed with error code 11000 and error message 'Index build failed: 548939ca-85ab-4efe-83a0-c2e1cecebbfd: Collection University.Kladr ( c773717c-6cd0-473a-90b9-e5440bd57893 ) :: caused by :: E11000 duplicate key error collection: University.Kladr index: details.name_1 dup key: { details.name: "1 Мая" }'

// Задание 13
// Создайте уникальный составной индекс по ключам name и code населенного пункта. Какой будет результат?
db.Kladr.createIndex({"details.name": 1, "details.code": 1}, {unique: true});

// Все хорошо

// Задание 14 (выполнить в mongosh)
db.Kladr.find({}, {"details.name": 1}).limit(5).showRecordId()

// Задание 15
// mongodump -h 127.0.0.1:27017 -d University -o /home/prianechka/reserve

// Задание 16
// mongorestore --db testdb2 /home/prianechka/reserve/University

// Задание 17
// mongorestore --db testdb3 --collection NewCollection /home/prianechka/reserve/University/NewCollection.bson
