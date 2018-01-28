Kafka single broker system.

Based on:

https://devops.profitbricks.com/tutorials/install-and-configure-apache-kafka-on-ubuntu-1604-1/

Need Vagrant, Ansible and VirturalBox or other hypervisor.

--  vagrant up

-- vagrant provision

Scripts will install Kafka and start up single broker system.

To test Kafka, create a sample topic with name "testing" in Apache Kafka.

To test system function do the following:

Open a new terminal to the VM (in a new shell):

-- vagrant ssh

Create topic "testing":

sudo /opt/Kafka/kafka_2.11-1.0.0/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1  --partitions 1 --topic testing

List available topics:

sudo /opt/Kafka/kafka_2.11-1.0.0/bin/kafka-topics.sh --list --zookeeper localhost:2181

Should respond with: testing

Publish sample messages:

sudo /opt/Kafka/kafka_2.11-1.0.0/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic testing

Enter some messages..

Open another new shell: vagrant ssh

Create a message consumer:

sudo /opt/Kafka/kafka_2.11-1.0.0/bin/kafka-console-consumer.sh --zookeeper localhost:2181 --topic testing --from-beginning

Should see the messages you entered in the producer terminal.
