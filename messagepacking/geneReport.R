MyData <- read.csv(file="stats.csv", header=TRUE, sep=",")
Avro<-MyData[MyData$V1=="Avro",]
Kryo<-MyData[MyData$V1=="Kryo",]
MessagePack<-MyData[MyData$V1=="MessagePack",]
Json<-MyData[MyData$V1=="Json",]

mean<-aggregate(MyData$V3, list(gp=MyData$V1, mean=MyData$V2), mean)
max<-aggregate(MyData$V3, list(gp=MyData$V1, max=MyData$V2), max)
min<-aggregate(MyData$V3, list(gp=MyData$V1, min=MyData$V2), min)

AvroMean<-aggregate(Avro$V3, list(nbMessage=Avro$V2), mean)
KryoMean<-aggregate(Kryo$V3, list(nbMessage=Kryo$V2), mean)
MessagePackMean<-aggregate(MessagePack$V3, list(nbMessage=MessagePack$V2), mean)
JsonMean<-aggregate(Json$V3, list(nbMessage=Json$V2), mean)

max_y <- max(mean$x)

plot(AvroMean$x, type="o", col="blue",ylim=c(0,max_y),  ann=FALSE)
lines(KryoMean$x, type="o", pch=22, lty=2,    col="red")
lines(MessagePackMean$x, type="o", pch=22, lty=2,    col="green")
lines(JsonMean$x, type="o", pch=22, lty=2,    col="black")

# Create a title with a red, bold/italic font
title(main="Write Time by Number of Message", col.main="black", font.main=2)

# Label the x and y axes with dark green text
title(xlab= "NbMessage", col.lab=rgb(0,0,0))
title(ylab= "Time", col.lab=rgb(0,0,0))
axis(1, at=1:12, lab=AvroMean$nbMessage)
legend(1, max_y, c("Avro","Kryo","MessagePack","Json"), cex=0.8, col=c("blue","red","green","black"), 
       pch=21:23, lty=1:3);


mean<-aggregate(MyData$V4, list(gp=MyData$V1, mean=MyData$V2), mean)
max<-aggregate(MyData$V4, list(gp=MyData$V1, max=MyData$V2), max)
min<-aggregate(MyData$V4, list(gp=MyData$V1, min=MyData$V2), min)

AvroMean<-aggregate(Avro$V4, list(nbMessage=Avro$V2), mean)
KryoMean<-aggregate(Kryo$V4, list(nbMessage=Kryo$V2), mean)
MessagePackMean<-aggregate(MessagePack$V4, list(nbMessage=MessagePack$V2), mean)
JsonMean<-aggregate(Json$V4, list(nbMessage=Json$V2), mean)

max_y <- max(mean$x)

plot(AvroMean$x, type="o", col="blue",ylim=c(0,max_y),  axes=FALSE,ann=FALSE)
lines(KryoMean$x, type="o", pch=22, lty=2,    col="red")
lines(MessagePackMean$x, type="o", pch=22, lty=2,    col="green")
lines(JsonMean$x, type="o", pch=22, lty=2,    col="black")

# Create a title with a red, bold/italic font
title(main="Read Time by Number of Message", col.main="black", font.main=2)

# Label the x and y axes with dark green text
title(xlab= "NbMessage", col.lab=rgb(0,0,0))
title(ylab= "Time", col.lab=rgb(0,0,0))
axis(1, at=1:12, lab=AvroMean$nbMessage)
legend(1, max_y, c("Avro","Kryo","MessagePack","Json"), cex=0.8, col=c("blue","red","green","black"), 
       pch=21:23, lty=1:3);


mean<-aggregate(MyData$V5, list(gp=MyData$V1, mean=MyData$V2), mean)
max<-aggregate(MyData$V5, list(gp=MyData$V1, max=MyData$V2), max)
min<-aggregate(MyData$V5, list(gp=MyData$V1, min=MyData$V2), min)

AvroMean<-aggregate(Avro$V5, list(nbMessage=Avro$V2), mean)
KryoMean<-aggregate(Kryo$V5, list(nbMessage=Kryo$V2), mean)
MessagePackMean<-aggregate(MessagePack$V5, list(nbMessage=MessagePack$V2), mean)
JsonMean<-aggregate(Json$V5, list(nbMessage=Json$V2), mean)

max_y <- max(mean$x)

plot(AvroMean$x, type="o", col="blue",ylim=c(0,max_y), axes=FALSE, ann=FALSE)
lines(KryoMean$x, type="o", pch=22, lty=2,    col="red")
lines(MessagePackMean$x, type="o", pch=22, lty=2,    col="green")
lines(JsonMean$x, type="o", pch=22, lty=2,    col="black")

# Create a title with a red, bold/italic font
title(main="File Size by Number of Message", col.main="black", font.main=2)

# Label the x and y axes with dark green text
title(xlab= "NbMessage", col.lab=rgb(0,0,0))
title(ylab= "File Size", col.lab=rgb(0,0,0))
axis(1, at=1:12, lab=AvroMean$nbMessage)
axis(2, at=0:max_y)
legend(1, max_y, c("Avro","Kryo","MessagePack","Json"), cex=0.8, col=c("blue","red","green","black"), 
       pch=21:23, lty=1:3);