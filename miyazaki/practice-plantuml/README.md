# practice PlantUml
This dirctory for practicing PlantUml

## How to install PlantUml

### Installing Java
You need to install java.

### Installing PlantUML
You should download jar file of Plant UML from following URL.

    [http://plantuml.sourceforge.net/download.html]("http://plantuml.sourceforge.net/download.html")

### Command line
PlantUML makes image file based on text file about source code.

Command syntax is following command line.

```
$ java -jar "path of plantuml.jar" [option] input file [...]
```

### Sample

#### Input file: sample.txt
```
@startuml images/sample.png
Foo -> Bar : メッセージ
Foo <-- Bar
@enduml
```

#### Command
```
$ java -jar "path of plantuml.jar" "path of sample.txt"
$ open image/sample.png
```

![]("https://github.com/tsutarou10/silver-rack-sandbox/blob/feature/practice-plantuml/miyazaki/practice-plantuml/imges/sample.png")



