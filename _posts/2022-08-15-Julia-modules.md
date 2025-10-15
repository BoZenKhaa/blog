# How-to on Julia modules, projects and packages

Julia The terms used in Julia to refer to logical blobs of code are  (sub)modules, (sub)projects and (sub)packages.

## File system structure

Structure of all Julia "projects" is made up from following "physical" parts:

- files (with `.jl` extension) containing sources

You combine source files together by using

```include("some_file.jl")```

in your sources. Include works the same way as in LaTex - it ONLY "replaces" the `include` with the `some_file.jl`.

Using `include` is the simplest way of organizing Julia code, but it is not very reusable.

## Logical structure

To handle namespaces practically reuse code, we can use modules and packages. 

To logically structure your project, you can use "Modules", "Environments/Projects" or "Packages".

## Module

## Environment/Project

## Packages

## Practical usage

### Julia in Jupyter - importing your modules

### Stacked environment

Should `Debugger` or `BenchmarkTools` be dependencies of your package? Probably not, but how do you use these tools without adding them to your environment? Usually, you should add them to your "main" environment, i.e., within your project:

```julia
(YourProject) pkg> activate # Activate default environment
  Activating project at `~/.julia/environments/v1.7`

(@v1.7) pkg> add Debugger
```

Then activate your project environment and you can use `Debugger` there. 

The mechanism why this works is a *Stacked environment* (<https://docs.julialang.org/en/v1/manual/code-loading/#Environment-stacks>), where your primary (project) environment is augmented by some secondary environment with tooling.

The environment stack is controlled by `LOAD_PATH` which [you can modify](https://stackoverflow.com/a/66791525/1400490) in your `startup.jl` file. By default, it holds

```julia
julia> LOAD_PATH
3-element Vector{String}:
 "@"
 "@v#.#"
 "@stdlib"
```

[where](https://stackoverflow.com/questions/63751818/packages-in-default-project/63751997#63751997) `@` is your current environment, `@v#.#` is your "default", i.e. `v1.7`, and `@stdlib` is the standard library.

## Creating a new package and CI

Just run julia repl and type
```Julia
(@v1.9) pkg> generate HelloWorld
```

Or, to make things easier later, use `PkgTemplates.jl` to configure the package and CI/CD. 

On github, you can set up automation for the packages. For Julia package, it is a good idea to use the following tools: 
 - Registrator - GitHub App that automatically registers new package versions in the Julia registry by opening PRs after you comment `@JuliaRegistrator register` in the selected commit on GitHub.
 - TagBot - GitHub Action that automatically creates a new tag and release on GitHub when a new version of package is registered in the Julia registry.
 - Documenter - GitHub Action that automatically builds and deploys documentation for your package.
 - Tests and Codecov - GitHub Actions that run tests and check the coverage of your package on each PR, each commit, etc. 

### CI/CD
 In Julia, CI/CD with GithubActions can be simplified with [Julia Actions](https://github.com/julia-actions) that provide ready-made scripts for CI configs.

#### Registrator and TagBot

Workflow when everything is set up:
1. update the `Project.toml`  to the new version, e.g. `0.1.1`. 
2. commit the changes and push to the repository. 
3. In github, nn the pushed commit or merged PR, comment `@JuliaRegistrator register`
This should register the package via Registrator, and tag the commit on Github and creat new release via TagBot.


[Registrator](https://github.com/JuliaComputing/Registrator.jl) works as a github app you have to install in Github. When you comment `@JuliaRegistrator register` in the commit, it will automatically register the package in the Julia registry. It can also trigger the TagBot action to tag and create a new release on GitHub.

You can add custom release comment with 
```
@JuliaRegistrator register

Release notes:

Check out my new features!
```
This will be included in the TagBot release as well.

##### TagBot.jl
When you create a releas of a Julia package, i.e., via Registrator, you can use TagBot to automatically create a new tag on github and create a realease. You can also use it to trigger documenter build. 

TagBot is configured by a `TagBot.yml` file in the `.github/workflows/TagBot.yml`. 

Current template of `TagBot.yml` is in the [project repository](https://github.com/JuliaRegistries/TagBot).

#### Documenter.jl

This [package](https://documenter.juliadocs.org/stable/) lets you create documentation for your package that combines dosctrings, custom markdown and julia code. 

The autodeployment of documentations is done with GithubActions and can be triggered by TagBot.


