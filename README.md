# Apache-Pig---Graph-Build
Builds a graph from a collection of merchant - customer pairs

Given a file containing merchant-customer pairs (e.g. transaction records), this file produces a weighted graph, where the nodes are the merchants and the weights on the edges are determined by number of shared customers. 

Output schema: merchant1,merchant2,weight
