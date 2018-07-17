package example
import com.esotericsoftware.kryo.Kryo
import com.esotericsoftware.kryo.io.Input
import com.esotericsoftware.kryo.io.Output
import java.io._

class User {
  var name:String=""
  var age:Int=0
  var cum:String=""
  def this(name:String,age:Int,cum:String) {
      this.name=name
      this.age=age
      this.cum=cum
  } 
}

trait Greeting {
  lazy val greeting: String = "hello"
}


object Hello extends Greeting with App {

  //Avro
  var schemav1 ="{\"namespace\": \"example.avro\",\"type\": \"record\",\"name\": \"User\",\"fields\": [ {\"name\": \"name\", \"type\": \"string\"}, {\"name\": \"age\",  \"type\": \"int\"},{\"name\": \"cum\", \"type\": [\"string\", \"null\"]}]}"
  var schemaVV1:Schema = new Schema.Parser().parse(schemav1);

  //Init Cryo
  var kryo:Kryo = new Kryo();
  kryo.register(classOf[ArrayList[User]]);
  kryo.register(classOf[User]);

  
  val mapper = new ObjectMapper();
  mapper.registerModule(DefaultScalaModule)


  
  println(greeting)




def functionGenerateKryo (file:File,seed:Long,nb:Int)  {
      var coll:ArrayList[User] = new ArrayList[User];
      val r = new scala.util.Random(seed)
      for (i <- 1 to nb) 
      coll.add(new (User("test",r.nextInt,"") ))
      var output:Output  = new Output(new FileOutputStream(file));
      kryo.writeObject(output, coll);
      output.close();
}

def functionReadKryo (file:File,seed:Long,nb:Int)  {
      var input:Input  = new Input(new FileInputStream(file));
      var object2:ArrayList[User] = kryo.readObject(input, classOf[ArrayList[User]]);
      input.close();   
}

def functionGenerateJson (file:File,seed:Long,nb:Int)  {
      var coll:ArrayList[User] = new ArrayList[User];
      val r = new scala.util.Random(seed)
      for (i <- 1 to nb) 
      coll.add(new (User("test",r.nextInt,"") ))
      objectMapper.writeValue(file, coll);
}

def functionReadJson (file:File,seed:Long,nb:int)  {
       var object2:ArrayList[User] = mapper.readValue(file, classOf[ArrayList[User]]);
}

def functionGenerateAvro (file:File,seed:Long,nb:Int)  {
      var coll:ArrayList[User] = new ArrayList[User];
      val r = new scala.util.Random(seed)
      var  dataFileWriter : DataFileWriter[GenericRecord]  = new DataFileWriter[GenericRecord](datumWriter);
      dataFileWriter.create(schemaVV1, file);
       for (i <- 1 to nb) {
        var user1:GenericRecord = new GenericData.Record(schemaVV1);
        user1.put("name", "test");
        user1.put("favorite_number", r.nextInt);
        dataFileWriter.append(user1);
      }
      
      dataFileWriter.close();
}

def functionReadAvro (file:File,seed:Long,nb:Int)  {
       var datumReader:DatumReader [GenericRecord]  = new GenericDatumReader[GenericRecord](schemaVV1);
  var dataFileReader:DataFileReader[GenericRecord] = new DataFileReader[GenericRecord](file, datumReader);
  var user:GenericRecord = null;
  while (dataFileReader.hasNext()) {
    // Reuse user object by passing it to next(). This saves us from
    // allocating and garbage collecting many objects for files with
    // many items.
    user = dataFileReader.next(user);
    println(user);
  }
}
      
}      

      

      
