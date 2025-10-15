# Gurobi

## Gurobi Floating license at CVUT

Quote from David Vecerka:

"Nase katedra provozuje licecnci server pro gurobi, aby sel vyuzivat v docker kontejnerech v BRUTE. Bezi na adrese: 147.32.84.36
Tento server se vyuziva i na RCI clusteru, kde jsou k dispozici gurobi moduly."

To [set up](https://support.gurobi.com/hc/en-us/articles/13264425253265) Gurobi with floating license, create a file `gurobi.lic` with the following content:
```bash
TOKENSERVER=mymachine.mydomain.com
```
