#!/usr/bin/env python3

from graphviz import Digraph

g = Digraph('G',
            filename='bayeux-deps.gv',
            node_attr={("shape", "box")})
g.attr(rankdir='BT')
# g.attr(compound='true')
   
with g.subgraph(name='cluster_System',
                edge_attr={'style' : 'invis'}) as systemCluster:
    # systemCluster.attr(rank='same')
    systemCluster.attr(style='filled', color='lightgrey', shape="box", penwidth="1.0", pencolor='black' )
    systemCluster.node("ubuntu",   label="Ubuntu 20.04LTS")
    systemCluster.node("gcc",      label="GCC 9.3")
    systemCluster.node("cmake",    label="CMake 3.16.3")
    systemCluster.node("gsl",      label="GSL 2.5")
    systemCluster.node("curl",     label="Curl 7.68.0")
    systemCluster.node("xerces-c", label="Xerces-C 3.2.2")
    systemCluster.node("boost",    label="Boost 1.71")
    systemCluster.node("make",     label="Make 4.2.1")
    systemCluster.node("ninja",    label="Ninja 1.10.0")
    systemCluster.node("doxygen",  label="Doxygen 1.8.17")
    systemCluster.node("protobuf",  label="Protobuf 3.6.1")
    systemCluster.edges([('gsl',      'gcc'),
                      ('boost',    'gcc'),
                      ('boost',    'ubuntu'),
                      ('doxygen',  'ubuntu'),
                      ('xerces-c', 'ubuntu'),
                      ('xerces-c', 'gcc'),
                      ('gcc',      'ubuntu'),
                      ('cmake',    'ubuntu'),
                      ('boost',    'gcc'),
                      ('make',     'ubuntu'),
                      ('ninja',    'ubuntu'),
                      ('make',     'gcc'),
                      ('ninja',    'gcc'),
                      ('cmake',    'make'),
                      ('cmake',    'ninja'),
                      ('protobuf', 'ubuntu'),
    ])
    systemCluster.attr(label='System', labelloc='b', labelfontsize="14",
                    labelfontname="times-bold", labeljust="l")


with g.subgraph(name='cluster_Libs') as libsCluster:
    libsCluster.attr(style='filled', color='white', penwidth="1.0", pencolor='blue')
    libsCluster.attr(label='Third Party Libraries', labelloc='b', labeljust="l")
    libsCluster.node("clhep",    label="CLHEP 2.1.4.2")
    libsCluster.node("g4data",   label="Geant4 Datasets 9.6.3")
    libsCluster.node("g4",       label="Geant4 9.6.3")
    libsCluster.node("root",     label="ROOT 6.16.00")
    libsCluster.node("camp",     label="CAMP 0.8.4")
    libsCluster.edge("clhep",    "gcc", style="invis")
    libsCluster.edge("camp",     "gcc", style="invis")
    libsCluster.edge("camp",     "boost")
    libsCluster.edge("root",     "ubuntu")
    libsCluster.edge("root",     "gcc", style="invis")
    libsCluster.edge("root",     "gsl")
    libsCluster.edge("g4",       "g4data")
    libsCluster.edge("g4",       "gcc", style="invis")
    libsCluster.edge("g4",       "clhep")
    libsCluster.edge("g4",       "xerces-c")

with g.subgraph(name='cluster_BxCppDev') as bxCppDevCluster:
    bxCppDevCluster.attr(style='filled', color='white', penwidth="1.0", pencolor='black')
    bxCppDevCluster.attr(label='BxCppDev Libraries', labelloc='t', labeljust="l")
    bxCppDevCluster.node("bxdecay",     label="BxDecay0 1.0.9")
    bxCppDevCluster.node("bxjsontools", label="BxJsontools 1.0.0")
    bxCppDevCluster.node("bxprotobuftools", label="BxProtobuftools 1.0.0")
    bxCppDevCluster.node("bxrabbitmq", label="BxRabbitMQ 1.0.0")
    bxCppDevCluster.node("bayeux",      label="Bayeux 3.4.4")
    bxCppDevCluster.node("bayeuxg4",    label="Bayeux Geant4 MC engine")
    bxCppDevCluster.node("bxinstallers", label="BxInstallers")
    
    bxCppDevCluster.edge("bxjsontools",  "boost")
    bxCppDevCluster.edge("bxdecay",  "gsl")
    bxCppDevCluster.edge("bxdecay",  "gcc", style="invis")
    bxCppDevCluster.edge("bxdecay",  "cmake", style="invis")
    bxCppDevCluster.edge("bxjsontools",  "gcc", style="invis")
    bxCppDevCluster.edge("bxjsontools",  "cmake", style="invis")
    bxCppDevCluster.edge("bxprotobuftools",  "gcc", style="invis")
    bxCppDevCluster.edge("bxprotobuftools",  "cmake", style="invis")
    bxCppDevCluster.edge("bxprotobuftools",  "protobuf", style="invis")
    bxCppDevCluster.edge("bayeux",    "cmake", style="invis")
    bxCppDevCluster.edge("bayeux",    "gcc", style="invis")
    bxCppDevCluster.edge("bayeuxg4",  "bayeux")
    bxCppDevCluster.edge("bayeux",   "gsl")
    bxCppDevCluster.edge("bayeux",   "bxdecay")
    bxCppDevCluster.edge("bayeux",   "camp")
    bxCppDevCluster.edge("bayeux",   "boost")
    bxCppDevCluster.edge("bayeux",   "root")
    bxCppDevCluster.edge("bayeux",   "clhep")
    bxCppDevCluster.edge("bayeuxg4", "g4")
    bxCppDevCluster.edge("bxrabbitmq",  "bxjsontools")
    bxCppDevCluster.edge("bxinstallers", "bxdecay", style="dotted")
    bxCppDevCluster.edge("bxinstallers", "bxjsontools", style="dotted")
    bxCppDevCluster.edge("bxinstallers", "bxprotobuftools", style="dotted")
    bxCppDevCluster.edge("bxinstallers", "bxrabbitmq", style="dotted")
    bxCppDevCluster.edge("bxinstallers", "bayeux", style="dotted")
    bxCppDevCluster.edge("bxinstallers", "bayeuxg4", style="dotted")
    bxCppDevCluster.edge("bxinstallers", "clhep", style="dotted")
    bxCppDevCluster.edge("bxinstallers", "root", style="dotted")
    bxCppDevCluster.edge("bxinstallers", "camp", style="dotted")
    bxCppDevCluster.edge("bxinstallers", "g4data", style="dotted")
    bxCppDevCluster.edge("bxinstallers", "g4", style="dotted")

g.view()
