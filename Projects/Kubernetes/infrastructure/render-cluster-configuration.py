from jinja2 import Environment, FileSystemLoader

env = Environment(loader=FileSystemLoader("./"))
template = env.get_template('cluster.tf.j2')

desiredservers = 4
sshkeys = [7172020, 7172181]
clustermembers = ["k8s-"+str(n) for n in range(1, desiredservers + 1)]

print(template.render(clustermembers=clustermembers, sshkeys=sshkeys))
