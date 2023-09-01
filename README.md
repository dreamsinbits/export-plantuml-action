# export-plantuml-action
GitHub Action for exporting PlantUML diagrams to images.
The action exports PlanUML diagram files to images.
This enables a continues integration for PlantUML diagrams.

## Inputs
### `args`

**Required** The arguments that are forwarded to PlantUML CLI. 

Default: `-svg ./`

## Example usage
Here's an example for a workflow which exports SVG images from PlantUML files.
The images are only exported for new or modified `.puml` files.
The generated images are commited and pushed to the repo in the last step.

```yaml
name: Export PlantUML diagrams

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

jobs:
  render-diagrams:
    runs-on: ubuntu-latest
    steps:
      # Checks-out your repository under $GITHUB_WORKSPACE, so your job can access it
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Get all changes files
        id: get-changed-files
        uses: jitterbit/get-changed-files@v1
      - name: Get changed UML files
        id: get-changed-uml-files
        run: |
          puml_files=''
          for changed_file in ${{ steps.get-changed-files.outputs.modified }}; do
            extension="${changed_file##*.}"

            if [ "${extension}" == "puml" ]; then
              # add puml file
              puml_files="${puml_files} ${changed_file}"
              echo "Added file: ${changed_file}"
            fi
          done
          echo "puml-files=${puml_files}" >> $GITHUB_OUTPUT

      - name: Generate SVG Diagrams
        uses: dreamsinbits/export-plantuml-action@v1
        with:
          args: -v -o out -tsvg -config diagrams/config/config.puml ${{ steps.get-changed-uml-files.outputs.puml-files }}
          
      - name: Push Local Changes
        uses:  stefanzweifel/git-auto-commit-action@v4.1.2 
        with: 
          commit_user_name: "PlantUML Diagramm Renderer"
          commit_user_email: "plantuml@your-domain.com"
          commit_author: "PLantUML <plantuml@your-domain.com>"
          commit_message: "Generated SVG images for PlantUML diagrams" 
          branch: ${{ github.head_ref }}
```
