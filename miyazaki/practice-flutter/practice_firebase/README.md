# practice_firebase

A new Flutter project to practice firebase.

## Desctiption of basic function

### submit()
The function of example can send Json data to firebase.

#### example

~~~
void submit() {
    FirebaseDatabase.instance.reference().child('0').set(
        {
            'age': "25",
            'gmail': "tatsumiya05@gmail.com",
            'lineid': "tsutarou52",
            'name': "Tatsuro Miyazaki",
            'sex': "1",
        }
    );
}
~~~

### update()
This function can update data in firebase realtime database.

The function of example update second record, "name" of Json data of which first record is "0".

In other words, you can update following data,

~~~
{
    "0": {
        "name": "hoge"
    }
}
~~~

with

~~~
{
    "0": {
        "name": "tatsuro"
    }
}
~~~


#### example
~~~
void update() {
    FirebaseDatabase.instance.reference().child('0').update(
        {
            'name': "tatsuro",
        }
    );
}
~~~

### delete()
This function of example can delete data in firebase realtime database.

It deletes Json data of which first record is "0".

#### example

~~~
void delete() {
    FirebaseDatabase.instance.reference().child('0').remove();
}
~~~

#### read()
The function of example can read data in firebase realtime database which you specify.

It reads Json data of which first record is "0".

#### example

~~~
void read() {
    FirebaseDatabase.instance.reference().child('0').once().then((DataSnapshot snapshot) {
    print('Data : ${snapshot.value}');
  });
}
~~~

