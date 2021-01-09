"""
Pluto2Jupyter module converts Pluto Notebooks to Jupyter Notebooks and viceversa

jl2nb("myfile.jl") 
to convert pluto Notebook to  "myfile.ipynb" Jupyter Notebook

nb2jl("myfile.ipynb")
to convert Jupyter Notebook to "myfile.jl" Pluto Notebook
"""
module Pluto2Jupyter
export nb2jl, jl2nb
using JSON, UUIDs, Pluto

"""
    nb2jl(path::AbstractString)

Convert Jupyter Notebook to Pluto Notebook
"""
function nb2jl(path::AbstractString)

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


"""
    jl2nb(path::AbstractString)

Convert Pluto Notebook to Jupyter Notebook
"""
function jl2nb(path::AbstractString)
    plutonb = Pluto.load_notebook_nobackup(path)
    nbcells = []
    counter = 1
    for cell in plutonb.cells
        tempcell = Dict("cell_type"=> "code",
        "metadata"=> Dict(),
        "source"=>[])

        if occursin(r"^(md\"\"\")",cell.code)
            tempcell["cell_type"]= "markdown"
            push!(tempcell["source"],cell.code[6:end-3])
        else
            push!(tempcell["source"],cell.code)
            tempcell["outputs"]=[]
            tempcell["execution_count"]= counter
            counter +=1
        end
        push!(nbcells,tempcell)
    end

    # Todo: get version and spec from the system
    language_info = Dict("file_extension" => ".jl",
    "mimetype" => "application/julia",
    "name" => "julia",
    "version" => "1.5.3")
    kernelspec = Dict(
        "display_name"=> "Julia 1.5.3",
        "language"=> "julia",
        "name"=> "julia-1.5"
       )
    metadata = Dict("language_info"=>language_info,
        "kernelspec"=>kernelspec)

    nb = Dict("cells"=>nbcells,
            "metadata" => metadata,
            "nbformat" => 4,
            "nbformat_minor" => 2)
            
    savepath = string(path[1:end-2],"ipynb")
    open(savepath,"w") do f
        write(f,JSON.json(nb))
    end
end


end