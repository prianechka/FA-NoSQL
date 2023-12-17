db.createCollection("Answers")

// mongoimport --jsonArray --db University --collection Restaurants --file /home/prianechka/nosql4/rest.json --maintainInsertionOrder --jsonArray

//    1. Напишите запрос MongoDB для отображения всех документов в коллекционных ресторанах.
db.Answers.insertOne({"1": db.Restaurants.find({}).toArray()});

//    2. Напишите запрос MongoDB, чтобы отобразить поля restaurant_id, name, район и кухня для всех документов в ресторане collection.
db.Answers.insertOne({"2": db.Restaurants.find({}, {restaurant_id: 1, name: 1, borough: 1, cuisine: 1}).toArray()});

//    3. Напишите запрос MongoDB, чтобы отобразить поля restaurant_id, name, район и кухня, но исключите поле _id для всех документов в ресторане коллекции.
db.Answers.insertOne({"3": db.Restaurants.find({}, {restaurant_id: 1, name: 1, borough: 1, cuisine: 1, _id: 0}).toArray()});

//    4. Напишите запрос MongoDB, чтобы отобразить поля restaurant_id, name, borough и zip code, но исключите поле _id для всех документов в ресторане коллекции.
db.Answers.insertOne({"4": db.Restaurants.find({}, {restaurant_id: 1, name: 1, borough: 1, "address.zipcode": 1, _id: 0}).toArray()});;

//    5. Напишите запрос MongoDB, чтобы отобразить весь ресторан, который находится в районе Бронкс.
db.Answers.insertOne({"5": db.Restaurants.find({borough: "Bronx"}).toArray()});

//    6. Напишите запрос MongoDB, чтобы отобразить первые 5 ресторанов, которые находятся в районе Бронкс.
db.Answers.insertOne({"6": db.Restaurants.find({borough: "Bronx"}).limit(5).toArray()});

//    7. Напишите запрос MongoDB, чтобы отобразить следующие 5 ресторанов после пропуска первых 5, которые находятся в районе Бронкса.
db.Answers.insertOne({"7": db.Restaurants.find({borough: "Bronx"}).skip(5).limit(5).toArray()});

//    8. Напишите запрос MongoDB, чтобы найти рестораны, набравшие более 90 баллов.
db.Answers.insertOne({"8": db.Restaurants.find({grades : { $elemMatch:{"score":{$gt : 90}}}}).toArray()});

//    9. Напишите запрос MongoDB, чтобы найти рестораны, которые набрали более 80, но менее 100 баллов.
db.Answers.insertOne({"9":
    db.Restaurants.find({grades : { $elemMatch:{"score":{$gt : 80 , $lt :100}}}}).toArray()
});

//    10. Напишите запрос MongoDB, чтобы найти рестораны, которые находят по широте меньше, чем -95.754168.
db.Answers.insertOne({"10":
    db.Restaurants.find({"address.coord" : {$lt : -95.754168}}).toArray()
});

//    11. Напишите запрос MongoDB, чтобы найти рестораны, которые не готовят ни одной «американской» кухни, с оценкой их баллов более 70 и широтой -65,754168.
db.Answers.insertOne({"11":
    db.Restaurants.find(
    {$and:  [
        {"cuisine" : {$ne :"American"}},
        {"grades.score" : {$gt : 70}},
        {"address.coord" : {$lt : -65.754168}}
    ]}).toArray()
});

//    12. Напишите запрос MongoDB, чтобы найти рестораны, которые не готовят ни одной «американской» кухни и набрали более 70 баллов и находятся на долготе менее -65,754168.
// Примечание. Выполните этот запрос, не используя $ и оператор.
db.Answers.insertOne({"12":
    db.Restaurants.find({
        "cuisine" : {$ne : "American "},
        "grades.score" :{$gt: 70},
        "address.coord" : {$lt : -65.754168}
    }).toArray()
});

//    13. Напишите запрос MongoDB, чтобы найти рестораны, которые не готовят ни одной «американской» кухни и получили оценку «А», не принадлежащую району Бруклин. Документ должен отображаться в соответствии с кухней в порядке убывания.
db.Answers.insertOne({"13":
    db.Restaurants.find({
        "cuisine" : {$ne : "American"},
        "grades.grade" :"A",
        "borough": {$ne : "Brooklyn"}
    }).sort({"cuisine":-1}).toArray()
});


//    14. Напишите запрос MongoDB, чтобы найти идентификатор ресторана, название, район и кухню для тех ресторанов, которые в качестве первых трех букв назвали «Wil».
db.Answers.insertOne({"14":
    db.Restaurants.find({name: /^Wil/},
    {
        "restaurant_id" : 1,
        "name":1,"borough":1,
        "cuisine" :1
    }).toArray()
});

//    15. Напишите запрос MongoDB, чтобы найти идентификатор ресторана, название, район и кухню для тех ресторанов, которые содержат «ces» в качестве последних трех букв в названии.
db.Answers.insertOne({"15":
    db.Restaurants.find({"name": {$regex: /^.*ces$/}},
    {
        "restaurant_id": 1,
        "name": 1,
        "borough": 1,
        "cuisine": 1
    }).toArray()
});

//    16. Напишите запрос MongoDB, чтобы найти идентификатор ресторана, название, район и кухню для тех ресторанов, которые содержат «Reg» в виде трех букв где-то в своем названии.
db.Answers.insertOne({"16":
    db.Restaurants.find({"name": /.*Reg.*/},
    {
        "restaurant_id": 1,
        "name": 1,
        "borough": 1,
        "cuisine": 1
    }).toArray()
});

//    17. Напишите запрос MongoDB, чтобы найти рестораны, которые относятся к району Бронкс и готовят американское или китайское блюдо.
db.Answers.insertOne({"17":
    db.Restaurants.find(
    {
        "borough": "Bronx",
        $or : [
            {"cuisine" : "American"},
            {"cuisine" : "Chinese"}
        ]
    }).toArray()
});

//    18. Напишите запрос MongoDB, чтобы найти идентификатор ресторана, название, район и кухню для тех ресторанов, которые относятся к району Статен-Айленд или Квинсу или Бронксор Бруклин.
db.Answers.insertOne({"18":
    db.Restaurants.find(
    {
        "borough" : {$in : ["Staten Island", "Queens", "Bronx", "Brooklyn"]}
    },
        {
            "restaurant_id" : 1,
            "name":1,"borough":1,
            "cuisine" :1
        }
    ).toArray()
});

//    19. Напишите запрос MongoDB, чтобы найти идентификатор ресторана, название, район и кухню для тех ресторанов, которые не относятся к району Стейтен-Айленд или Квинсу или Бронксору Бруклину.
db.Answers.insertOne({"19":
    db.Restaurants.find(
    {
        "borough" : {$nin : ["Staten Island", "Queens", "Bronx", "Brooklyn"]}
    },
        {
            "restaurant_id" : 1,
            "name":1,"borough":1,
            "cuisine" :1
        }
    ).toArray()
});

//    20. Напишите запрос MongoDB, чтобы найти идентификатор ресторана, название, район и кухню для тех ресторанов, которые набрали не более 10 баллов.
db.Answers.insertOne({"20":
    db.Restaurants.find(
    {"grades.score" : { $not: {$gt : 10}}},
    {
        "restaurant_id" : 1,
        "name":1,"borough":1,
        "cuisine" :1
    }).toArray()
});


//    21. Напишите запрос MongoDB, чтобы найти идентификатор ресторана, название, район и кухню для тех ресторанов, в которых готовили блюда, кроме «американский» и «китайский», или название ресторана начинается с буквы «Wil».
db.Answers.insertOne({"21":
    db.Restaurants.find(
        {$or: [
            {name: /^Wil/},
            {"$and": [
               {"cuisine" : {$ne :"American "}},
               {"cuisine" : {$ne :"Chinees"}}
            ]}
        ]},
        {
            "restaurant_id": 1,
            "name": 1,
            "borough": 1,
            "cuisine": 1
        }).toArray()
});

//    22. Напишите запрос MongoDB, чтобы найти идентификатор ресторана, название и оценки для тех ресторанов, которые достигли оценки «А» и набрали 11 баллов по ISODate «2014-08-11T00: 00: 00Z» среди многих дат опросов.
db.Answers.insertOne({"22":
    db.Restaurants.find({
    "grades" : {$elemMatch: {"date": ISODate("2014-08-11T00:00:00Z"), "grade":"A", "score":11}}},
    {
        _id : 0,
        restaurant_id: 1,
        name: 1,
        grades: 1
    }).toArray()
});


//    23. Напишите запрос MongoDB, чтобы найти идентификатор ресторана, название и оценки для тех ресторанов, где 2-й элемент массива оценок содержит оценку «А» и оценку 9 на ISODate «2014-08-11T00: 00: 00Z».
db.Answers.insertOne({"23":
    db.Restaurants.find(
    {$and: [{"grades.1.grade": "A"}, {"grades.1.score": 9}, {"grades.1.date": ISODate("2014-08-11T00:00:00Z")}]},
    {
        _id : 0,
        restaurant_id: 1,
        name: 1,
        grades: 1
    }).toArray()
});

//    24. Напишите запрос MongoDB, чтобы найти идентификатор ресторана, название, адрес и географическое местоположение для тех ресторанов, где 2-й элемент массива координат содержит значение, которое больше 42 и до 52.
db.Answers.insertOne({"24":
    db.Restaurants.find(
    {$and : [{"address.coord.1": {$gt : 42}},{"address.coord.1": {$lte : 52}}]},
    {
        _id: 0,
        restaurant_id: 1,
        name: 1,
        address: 1
    }).toArray()
});

//    25. Напишите запрос MongoDB, чтобы расположить названия ресторанов в порядке возрастания вместе со всеми столбцами.
db.Answers.insertOne({"25":db.Restaurants.find({}).sort({name: 1}).toArray()});

//    26. Напишите запрос MongoDB, чтобы расположить названия ресторанов по убыванию вместе со всеми столбцами.
db.Answers.insertOne({"26": db.Restaurants.find({}).sort({name: -1}).toArray()});

//    27. Напишите запрос MongoDB, чтобы расположить название кухни в порядке возрастания, а для этой же кухни район должен быть в порядке убывания.
db.Answers.insertOne({"27": db.Restaurants.find({}, {_id:0, cuisine:1, borough:1}).sort({cuisine: 1, borough: -1}).toArray()});

//    28. Напишите запрос MongoDB, чтобы узнать, содержит ли все адреса улицу или нет.
db.Answers.insertOne({"28": db.Restaurants.find({"address.street" : {$exists : false }}).toArray().length});

//    29. Напишите запрос MongoDB, который выберет все документы в коллекции ресторанов, где значение поля координат равно Double.
db.Answers.insertOne({"29": db.Restaurants.find({"address.coord": {$type: "double"}}).toArray()});

//    30. Напишите запрос MongoDB, который выберет идентификатор ресторана, название и оценки для тех ресторанов, который возвращает 0 в качестве остатка после деления счета на 7.
db.Answers.insertOne({"30":
    db.Restaurants.find({"grades": {$elemMatch: {"score": {$mod: [7, 0]}}}},
    {
        _id: 0,
        restaurant_id: 1,
        name: 1,
        grades: 1
    }).toArray()
});

//    31. Напишите запрос MongoDB, чтобы найти название ресторана, район, долготу и отношение, а также кухню для тех ресторанов, в которой где-то в названии есть три буквы «mon».
db.Answers.insertOne({"31":
    db.Restaurants.find({name: {$regex: /mon/}},
    {
        _id: 0,
        name: 1,
        borough: 1,
        "address.coord": 1,
        cuisine: 1
    }).toArray()
});

//    32. Напишите запрос MongoDB, чтобы найти название ресторана, район, долготу и широту и кухню для тех ресторанов, в которых первые три буквы названия - «Mad».
db.Answers.insertOne({"32":
    db.Restaurants.find({name: {$regex: /^Mad.*/}},
    {
        _id: 0,
        name: 1,
        borough: 1,
        "address.coord": 1,
        cuisine: 1
    }).toArray()
});
