### A Pluto.jl notebook ###
# v0.12.18

using Markdown
using InteractiveUtils

# ╔═╡ 5dca09ac-523b-11eb-114b-af44490cde43
md"""
## Test1

This is an example notebook that includes markdowns and codes
- Equations: $ T = \alpha^2 $
- [julia](https://julialang.org)
"""

# ╔═╡ 700e8cc8-523b-11eb-2a95-8deb15bc31aa
function f(x,y)
    return x+y
end

# ╔═╡ 24642772-523a-11eb-1b5c-81b8a551b287
f(5,4)

# ╔═╡ 61cf7cd0-523a-11eb-1b81-b5430d6f9a59
# Blank line

# ╔═╡ d0d169f6-523b-11eb-3343-71773743c057
begin
	f(5,4)
	f(3,2)
end

# ╔═╡ d9dcff7e-523b-11eb-3d36-c17f4cda88bd
begin
	a = 5
	b = 6
	f(a,b)
end

# ╔═╡ Cell order:
# ╟─5dca09ac-523b-11eb-114b-af44490cde43
# ╠═700e8cc8-523b-11eb-2a95-8deb15bc31aa
# ╠═24642772-523a-11eb-1b5c-81b8a551b287
# ╠═61cf7cd0-523a-11eb-1b81-b5430d6f9a59
# ╠═d0d169f6-523b-11eb-3343-71773743c057
# ╠═d9dcff7e-523b-11eb-3d36-c17f4cda88bd
