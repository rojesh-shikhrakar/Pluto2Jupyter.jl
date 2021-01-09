# Pluto2Jupyter.jl

Pluto2Jupyter converts Pluto Notebooks to Jupyter Notebooks and vice versa.

## Usage

Convert "myfile.jl" Pluto Notebook to  "myfile.ipynb" Jupyter notebook

`jl2nb("myfile.jl")`

Convert "myfile.ipynb" Jupyter Notebook to  "myfile.jl" Pluto notebook

`nb2jl("myfile.ipynb")`

## Key Features

- [ ] Cell Structures are kept intact
  - [X] Markdown are wrapped around md"""triple quotes"""
  - [ ] Multiple Expressions wrapped around  begin-end block
- [X] Skips Cells begining with `;` or `?`
- [X] No Python Dependency

## Potential Issues
- Pluto doesnot allow multiple definition for same variable name in different blocks but jupyter notebook does.
