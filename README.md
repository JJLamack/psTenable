# psTenable

A PowerShell Module to interface with the different Tenable API's.

## Project Format

Lists what each folder's general purpose is.

### psTenable Folder

Actual source code of our Tenable API powershell module.

### Tests Folder

[Pester](https://pester.dev/) folder used to store all tests for the `psTenable` module.

### website Folder

Built with [Docusaurus](https://docusaurus.io/). Function/Command documentation is pulled from the `psTenable` directory using [Docusaurus.Powershell](https://docusaurus-powershell.vercel.app/).

### Files

Lists each individual file in root. providing general use case for each.

#### build.ps1

used to build module consistantly. Update Manifest file each build, runs Pester tests, and updates command documentation for the website.

## Inspired By

These modules where heavily inspired by [pyTenable](https://github.com/tenable/pyTenable) and the [powerAlto](https://github.com/brianaddicks/poweralto) projects.
