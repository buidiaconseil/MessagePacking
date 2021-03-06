MyData <- read.csv(file="stats2.csv", header=FALSE, sep=",")
MyData$V5=MyData$V5/1024
MyData$V6=(MyData$V5)/MyData$V3
MyData$V7=(MyData$V5)/MyData$V4
MyData$V2=MyData$V2/1000
Avro<-MyData[MyData$V1=="Avro",]
Kryo<-MyData[MyData$V1=="Kryo",]
MessagePack<-MyData[MyData$V1=="MessagePack",]
Json<-MyData[MyData$V1=="Json",]
ProtoStuff<-MyData[MyData$V1=="ProtoStuff",]

mean<-aggregate(MyData$V3, list(gp=MyData$V1, mean=MyData$V2), mean)
max<-aggregate(MyData$V3, list(gp=MyData$V1, max=MyData$V2), max)
min<-aggregate(MyData$V3, list(gp=MyData$V1, min=MyData$V2), min)

AvroMean<-aggregate(Avro$V6, list(nbMessage=Avro$V2), mean)
KryoMean<-aggregate(Kryo$V6, list(nbMessage=Kryo$V2), mean)
KryoMax<-aggregate(Kryo$V6, list(nbMessage=Kryo$V2), max)
KryoMin<-aggregate(Kryo$V6, list(nbMessage=Kryo$V2), min)
MessagePackMean<-aggregate(MessagePack$V6, list(nbMessage=MessagePack$V2), mean)
JsonMean<-aggregate(Json$V6, list(nbMessage=Json$V2), mean)
ProtoStuffMean<-aggregate(ProtoStuff$V6, list(nbMessage=ProtoStuff$V2), mean)

max_y <- max(AvroMean$x,MessagePackMean$x,JsonMean$x)*1.3

listLab<-c("Avro","Kryo","MessagePack","Json","ProtoStuff")
#listLab<-c("Avro","Kryo","Json")
listCol<-c("blue","red","green","black","orange")
#listCol<-c("blue","red","black")
listLab<-c("Avro","Kryo","MessagePack","Json")
listCol<-c("blue","red","green","black")

plot(AvroMean$nbMessage,AvroMean$x, type="o", col="blue",ylim=c(0,max_y),  ann=FALSE)
lines(KryoMean$nbMessage,KryoMean$x, type="o", pch=22, lty=2,    col="red")
lines(MessagePackMean$nbMessage,MessagePackMean$x, type="o", pch=22, lty=2,    col="green")
lines(JsonMean$nbMessage,JsonMean$x, type="o", pch=22, lty=2,    col="black")
#lines(ProtoStuffMean$nbMessage,ProtoStuffMean$x, type="o", pch=22, lty=2,    col="orange")

# Create a title with a red, bold/italic font
title(main="Serialization Speed by Number of Message", col.main="black", font.main=2)

# Label the x and y axes with dark green text
title(xlab= "NbMessage by 1000", col.lab=rgb(0,0,0))
title(ylab= "Kb/s", col.lab=rgb(0,0,0))

legend(1, max_y, listLab, cex=0.8, col=listCol, 
       pch=21:23, lty=1:3);


AvroMean<-aggregate(Avro$V7, list(nbMessage=Avro$V2), mean)
KryoMean<-aggregate(Kryo$V7, list(nbMessage=Kryo$V2), mean)
KryoMax<-aggregate(Kryo$V7, list(nbMessage=Kryo$V2), max)
KryoMin<-aggregate(Kryo$V7, list(nbMessage=Kryo$V2), min)
MessagePackMean<-aggregate(MessagePack$V7, list(nbMessage=MessagePack$V2), mean)
JsonMean<-aggregate(Json$V7, list(nbMessage=Json$V2), mean)
ProtoStuffMean<-aggregate(ProtoStuff$V7, list(nbMessage=ProtoStuff$V2), mean)

AvroMean <- AvroMean[!is.infinite(AvroMean$x),]
KryoMean <- KryoMean[!is.infinite(KryoMean$x),]
MessagePackMean <- MessagePackMean[!is.infinite(MessagePackMean$x),]
JsonMean <- JsonMean[!is.infinite(JsonMean$x),]

max_y <- max(AvroMean$x,MessagePackMean$x,JsonMean$x)*1.3

listLab<-c("Avro","Kryo","MessagePack","Json","ProtoStuff")
#listLab<-c("Avro","Kryo","Json")
listCol<-c("blue","red","green","black","orange")
#listCol<-c("blue","red","black")
listLab<-c("Avro","Kryo","MessagePack","Json")
listCol<-c("blue","red","green","black")

plot(AvroMean$nbMessage,AvroMean$x, type="o", col="blue",ylim=c(0,max_y),  ann=FALSE)
lines(KryoMean$nbMessage,KryoMean$x, type="o", pch=22, lty=2,    col="red")
lines(MessagePackMean$nbMessage,MessagePackMean$x, type="o", pch=22, lty=2,    col="green")
lines(JsonMean$nbMessage,JsonMean$x, type="o", pch=22, lty=2,    col="black")
#lines(ProtoStuffMean$nbMessage,ProtoStuffMean$x, type="o", pch=22, lty=2,    col="orange")

# Create a title with a red, bold/italic font
title(main="Deserialisation Speed by Number of Message", col.main="black", font.main=2)

# Label the x and y axes with dark green text
title(xlab= "NbMessage by 1000", col.lab=rgb(0,0,0))
title(ylab= "Kb/s", col.lab=rgb(0,0,0))

legend(1, max_y, listLab, cex=0.8, col=listCol, 
       pch=21:23, lty=1:3);

AvroMean<-aggregate(Avro$V3, list(nbMessage=Avro$V2), mean)
KryoMean<-aggregate(Kryo$V3, list(nbMessage=Kryo$V2), mean)
KryoMax<-aggregate(Kryo$V3, list(nbMessage=Kryo$V2), max)
KryoMin<-aggregate(Kryo$V3, list(nbMessage=Kryo$V2), min)
MessagePackMean<-aggregate(MessagePack$V3, list(nbMessage=MessagePack$V2), mean)
JsonMean<-aggregate(Json$V3, list(nbMessage=Json$V2), mean)
ProtoStuffMean<-aggregate(ProtoStuff$V3, list(nbMessage=ProtoStuff$V2), mean)

max_y <- max(mean$x)

listLab<-c("Avro","Kryo","MessagePack","Json","ProtoStuff")
#listLab<-c("Avro","Kryo","Json")
listCol<-c("blue","red","green","black","orange")
#listCol<-c("blue","red","black")
listLab<-c("Avro","Kryo","MessagePack","Json")
listCol<-c("blue","red","green","black")

plot(AvroMean$nbMessage,AvroMean$x, type="o", col="blue",ylim=c(0,max_y),  ann=FALSE)
lines(KryoMean$nbMessage,KryoMean$x, type="o", pch=22, lty=2,    col="red")
lines(KryoMean$nbMessage,KryoMax$x, type="o", pch=22, lty=2,    col="red")
lines(KryoMean$nbMessage,KryoMin$x, type="o", pch=22, lty=2,    col="red")
lines(MessagePackMean$nbMessage,MessagePackMean$x, type="o", pch=22, lty=2,    col="green")
lines(JsonMean$nbMessage,JsonMean$x, type="o", pch=22, lty=2,    col="black")
#lines(ProtoStuffMean$nbMessage,ProtoStuffMean$x, type="o", pch=22, lty=2,    col="orange")

# Create a title with a red, bold/italic font
title(main="Serialization Time by Number of Message", col.main="black", font.main=2)

# Label the x and y axes with dark green text
title(xlab= "NbMessage by 1000", col.lab=rgb(0,0,0))
title(ylab= "Time (s)", col.lab=rgb(0,0,0))

legend(1, max_y, listLab, cex=0.8, col=listCol, 
       pch=21:23, lty=1:3);


mean<-aggregate(MyData$V4, list(gp=MyData$V1, mean=MyData$V2), mean)
max<-aggregate(MyData$V4, list(gp=MyData$V1, max=MyData$V2), max)
min<-aggregate(MyData$V4, list(gp=MyData$V1, min=MyData$V2), min)

AvroMean<-aggregate(Avro$V4, list(nbMessage=Avro$V2), mean)
KryoMean<-aggregate(Kryo$V4, list(nbMessage=Kryo$V2), mean)
MessagePackMean<-aggregate(MessagePack$V4, list(nbMessage=MessagePack$V2), mean)
JsonMean<-aggregate(Json$V4, list(nbMessage=Json$V2), mean)
ProtoStuffMean<-aggregate(ProtoStuff$V4, list(nbMessage=ProtoStuff$V2), mean)

max_y <- max(mean$x)

plot(AvroMean$nbMessage,AvroMean$x, type="o", col="blue",ylim=c(0,max_y),  axes=TRUE,ann=FALSE)
lines(KryoMean$nbMessage,KryoMean$x, type="o", pch=22, lty=2,    col="red")
lines(MessagePackMean$nbMessage,MessagePackMean$x, type="o", pch=22, lty=2,    col="green")
lines(JsonMean$nbMessage,JsonMean$x, type="o", pch=22, lty=2,    col="black")
#lines(ProtoStuffMean$nbMessage,ProtoStuffMean$x, type="o", pch=22, lty=2,    col="orange")

# Create a title with a red, bold/italic font
title(main="Deserialization Time by Number of Message", col.main="black", font.main=2)

# Label the x and y axes with dark green text
title(xlab=  "NbMessage by 1000", col.lab=rgb(0,0,0))
title(ylab= "Time (s)", col.lab=rgb(0,0,0))

legend(1, max_y, listLab, cex=0.8, col=listCol, 
       pch=21:23, lty=1:3);


mean<-aggregate(MyData$V5, list(gp=MyData$V1, mean=MyData$V2), mean)
max<-aggregate(MyData$V5, list(gp=MyData$V1, max=MyData$V2), max)
min<-aggregate(MyData$V5, list(gp=MyData$V1, min=MyData$V2), min)

AvroMean<-aggregate(Avro$V5, list(nbMessage=Avro$V2), mean)
KryoMean<-aggregate(Kryo$V5, list(nbMessage=Kryo$V2), mean)
MessagePackMean<-aggregate(MessagePack$V5, list(nbMessage=MessagePack$V2), mean)
JsonMean<-aggregate(Json$V5, list(nbMessage=Json$V2), mean)
ProtoStuffMean<-aggregate(ProtoStuff$V5, list(nbMessage=ProtoStuff$V2), mean)

max_y <- max(mean$x)

plot(AvroMean$nbMessage,AvroMean$x, type="o", col="blue",ylim=c(0,max_y), axes=TRUE, ann=FALSE)
lines(KryoMean$nbMessage,KryoMean$x, type="o", pch=22, lty=2,    col="red")
lines(MessagePackMean$nbMessage,MessagePackMean$x, type="o", pch=22, lty=2,    col="green")
lines(JsonMean$nbMessage,JsonMean$x, type="o", pch=22, lty=2,    col="black")
#lines(ProtoStuffMean$nbMessage,ProtoStuffMean$x, type="o", pch=22, lty=2,    col="orange")

# Create a title with a red, bold/italic font
title(main="File Size by Number of Message", col.main="black", font.main=2)

# Label the x and y axes with dark green text
title(xlab=  "NbMessage by 1000", col.lab=rgb(0,0,0))
title(ylab= "File Size (Kb)", col.lab=rgb(0,0,0))

legend(1, max_y, listLab, cex=0.8, col=listCol,pch=21:23, lty=1:3)