using Test
using Pluto2Jupyter

nb2jl(joinpath(@__DIR__, "test1.ipynb"))
jl2nb(joinpath(@__DIR__, "test2.jl"))