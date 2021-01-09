"""
Pluto2Jupyter module converts Pluto Notebooks to Jupyter Notebooks and viceversa

jl2nb("myfile.jl") 
to convert pluto Notebook to  "myfile.ipynb" Jupyter Notebook

nb2jl("myfile.ipynb")
to convert Jupyter Notebook to "myfile.jl" Pluto Notebook
"""
module Pluto2Jupyter

using JSON, UUIDs, Pluto

"""
    nb2jl(path::AbstractString)

Convert Jupyter Notebook to Pluto Notebook
"""
function nb2jl(path::AbstractString)
    # test if Notebook file
    nb = open(JSON.parse, path, "r")

    # test if notebook is acceptable
    nb["nbformat"] == 4 || error("unrecognized version", nb["nbformat"])
    lang = lowercase(nb["metadata"]["language_info"]["name"])
    lang == "julia" || error("notebook is for unregognized language $lang")

    # Shell or help mode
    sh_mode = r"^\s*[;?]"

    nbcells = Array{Pluto.Cell}(undef,0)
    for cell in nb["cells"]
        if cell["cell_type"] == "markdown"
            code = string("md\"\"\"",join(cell["source"]),"\n\"\"\"")
        elseif cell["cell_type"] == "code"
            code = join(cell["source"]) 
            occursin(sh_mode, code) && continue  # skip ? and ;
        end
        push!(nbcells,Pluto.Cell(uuid1(),code))
    end
    
    savepath = string(path[1:end-5],"jl")
    plutonb = Pluto.Notebook(nbcells,savepath)
    Pluto.save_notebook(plutonb,savepath);
end


end