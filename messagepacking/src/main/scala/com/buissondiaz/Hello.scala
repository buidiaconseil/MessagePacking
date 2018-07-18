package com.buissondiaz
import com.esotericsoftware.kryo.Kryo
import com.esotericsoftware.kryo.io.Input
import com.esotericsoftware.kryo.io.Output
import java.io._
import java.util._
//import org.apache.avro.io._ 
import org.apache.avro.generic._
//import org.apache.avro._
import org.apache.avro.file._
import java.io.File
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.core.`type`.TypeReference
import com.fasterxml.jackson.module.scala.experimental.ScalaObjectMapper
import com.fasterxml.jackson.module.scala.{DefaultScalaModule, JsonScalaEnumeration}
import org.msgpack.core.MessagePack;
import org.msgpack.core.MessagePack.PackerConfig;
import org.msgpack.core.MessagePack.UnpackerConfig;
import org.msgpack.core.MessageBufferPacker;
import org.msgpack.core.MessageFormat;
import org.msgpack.core.MessagePacker;
import org.msgpack.core.MessageUnpacker;
import org.msgpack.value.ArrayValue;
import org.msgpack.value.ExtensionValue;
import org.msgpack.value.FloatValue;
import org.msgpack.value.IntegerValue;
import org.msgpack.value.Value;
import io.protostuff.runtime._
class User {
  var name:String=""
  var age:Int=0
  var cum:String=""

  def this(name:String,age:Int,cum:String) {
      this()
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
  var schemaVV1:org.apache.avro.Schema = new org.apache.avro.Schema.Parser().parse(schemav1);

  //Init Cryo
  var kryo:Kryo = new Kryo();
  kryo.register(classOf[ArrayList[User]]);
  kryo.register(classOf[User]);

  //Json
  val mapper = new ObjectMapper();
  mapper.registerModule(DefaultScalaModule)

  // Protostuff
  val schema:io.protostuff.Schema[User] = RuntimeSchema.getSchema(classOf[User])
  RuntimeSchema.register(classOf[User], schema);
  
  System.setProperty("protostuff.runtime.collection_schema_on_repeated_fields", "true");
  


  var file:File = new File("test.sav")
  var seed:Long = 15
  val pw = new PrintWriter(new File("stats2.csv" ))
  var listSeq=Seq(1, 10, 100,1000,2000,5000,10000,100000,200000,300000,400000,500000,600000,700000,800000,900000,1000000,2000000,3000000,4000000,5000000,10000000,11000000,14000000,15000000,17000000,19000000,20000000,25000000,27000000,30000000,31000000).sorted
  for (i <- 1 to 30) 
  for (i <- listSeq)   {
    functionAll(functionGenerateKryo,functionReadKryo,file,seed,i,"Kryo")
    if(i<12000000)
    functionAll(functionGenerateJson,functionReadJson,file,seed,i,"Json")
    functionAll(functionGenerateAvro,functionReadAvro,file,seed,i,"Avro")
    functionAll(functionGenerateMessagePack,functionReadMessagePack,file,seed,i,"MessagePack")
    functionAll(functionGenerateProtoStuff,functionReadMessageProtoStuff,file,seed,i,"ProtoStuff")
  }
  pw.close
  
  println(greeting)

   

def functionAll (function1: (File, Long, Int) => Unit,function2: (File, Long, Int) => Unit,file:File,seed:Long,nb:Int,name:String){
  file.delete
  System.gc
  println("Start "+name+" "+nb)
  var timeStart=System.currentTimeMillis
  function1(file,seed,nb)
  var timeInt:Long=System.currentTimeMillis
  var length:Long=file.length
  var timeIntStart:Long=System.currentTimeMillis
  function2 (file,seed,nb)
  var timeEnd:Long=System.currentTimeMillis
  pw.write(name+","+nb+","+(timeInt-timeStart)/1000.0+","+(timeEnd-timeIntStart)/1000.0+","+length+"\n")
  pw.flush
  file.delete
}

def functionGenerateKryo (file:File,seed:Long,nb:Int)  {
      var coll:ArrayList[User] = new ArrayList[User];
      val r = new scala.util.Random(seed)
      for (i <- 1 to nb) 
      coll.add(new User("test",r.nextInt,"") )
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
      coll.add(new User("test",r.nextInt,"") )
      mapper.writeValue(file, coll);
}

def functionReadJson (file:File,seed:Long,nb:Int)  {
       var object2:ArrayList[User] = mapper.readValue(file, classOf[ArrayList[User]]);
}

def functionGenerateAvro (file:File,seed:Long,nb:Int)  {
      var coll:ArrayList[User] = new ArrayList[User];
      val r = new scala.util.Random(seed)
      var  datumWriter : org.apache.avro.io.DatumWriter[GenericRecord]  = new GenericDatumWriter[GenericRecord](schemaVV1);
      var  dataFileWriter : DataFileWriter[GenericRecord]  = new DataFileWriter[GenericRecord](datumWriter);
      dataFileWriter.create(schemaVV1, file);
       for (i <- 1 to nb) {
        var user1:GenericRecord = new GenericData.Record(schemaVV1);
        user1.put("name", "test");
        user1.put("age", r.nextInt);
        user1.put("cum", "");
        dataFileWriter.append(user1);
      }
      
      dataFileWriter.close();
}

def functionReadAvro (file:File,seed:Long,nb:Int)  {
       var datumReader:org.apache.avro.io.DatumReader [GenericRecord]  = new GenericDatumReader[GenericRecord](schemaVV1);
  var dataFileReader:DataFileReader[GenericRecord] = new DataFileReader[GenericRecord](file, datumReader);
  var user:GenericRecord = null;
  while (dataFileReader.hasNext()) {
    // Reuse user object by passing it to next(). This saves us from
    // allocating and garbage collecting many objects for files with
    // many items.
    user = dataFileReader.next(user);
  }
}

def functionGenerateMessagePack (file:File,seed:Long,nb:Int)  {
      var coll:ArrayList[User] = new ArrayList[User];
      val r = new scala.util.Random(seed)
      var packer:MessagePacker = MessagePack.newDefaultPacker(new FileOutputStream(file));
       for (i <- 1 to nb) {
        packer.packString( "test");
        packer.packInt(r.nextInt);
        packer.packString( "");
      }
      
      packer.close()
}

def functionReadMessagePack (file:File,seed:Long,nb:Int)  {
  val unpacker:MessageUnpacker = MessagePack.newDefaultUnpacker(new FileInputStream(file));
  while (unpacker.hasNext()) {
            // [Advanced] You can check the detailed data format with getNextFormat()
            // Here is a list of message pack data format: https://github.com/msgpack/msgpack/blob/master/spec.md#overview
    val format:MessageFormat = unpacker.getNextFormat();

            // You can also use unpackValue to extract a value of any type
    val v:Value = unpacker.unpackValue();
    v.getValueType()
  }

}

def functionGenerateProtoStuff (file:File,seed:Long,nb:Int)  {
    
      var coll:ArrayList[User] = new ArrayList[User];
      var output:Output  = new Output(new FileOutputStream(file));
      val r = new scala.util.Random(seed)
      var byteList:Array[Byte]=Array()
      for (i <- 1 to nb) {
        val buffer:io.protostuff.LinkedBuffer = io.protostuff.LinkedBuffer.allocate(512)
        var protostuff:Array[Byte]=null;
        //coll.add(new User("test",r.nextInt,"") )
        protostuff = io.protostuff.ProtostuffIOUtil.toByteArray(new User("test",r.nextInt,""), schema, buffer);
        var combined:Array[Byte] = new Array[Byte](byteList.length + protostuff.length);
        System.arraycopy(byteList,0,combined,0         ,byteList.length);
        System.arraycopy(protostuff,0,combined,byteList.length,protostuff.length);
      }
      val bos = new FileOutputStream(file)
      bos.write(byteList)
      bos.close()
      //val size = io.protostuff.ProtostuffIOUtil.writeTo(output, coll, schema, buffer)
      //println(size)
      //output.close();
      
}

def functionReadMessageProtoStuff (file:File,seed:Long,nb:Int)  {
  var coll:ArrayList[User] = new ArrayList[User]
  var input:Input  = new Input(new FileInputStream(file))
  val buffer:io.protostuff.LinkedBuffer = io.protostuff.LinkedBuffer.allocate(5120000)
  val bis = new FileInputStream(file)
  val bArray = Stream.continually(bis.read).takeWhile(-1 !=).map(_.toByte).toArray
 // io.protostuff.ProtostuffIOUtil.mergeFrom(input, coll,  schema, buffer)
  println(coll.size)
  //println(coll.iterator.next)
}


}
      

      
