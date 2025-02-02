# The release workflow 
The release workflow recommended by the ODK is based on GitHub releases and works as follows:

1. Run a release with the ODK
2. Review the release
3. Merge to main branch
4. Create a GitHub release

These steps are outlined in detail in the following.

## Run a release with the ODK

Preparation:

1. Ensure that all your pull requests are merged into your main (master) branch
2. Make sure that all changes to master are committed to Github (`git status` should say that there are no modified files)
3. Locally make sure you have the latest changes from master (`git pull`)
4. Checkout a new branch (e.g. `git checkout -b release-2021-01-01`)
5. You may or may not want to refresh your imports as part of your release strategy (see [here](UpdateImports.md))
6. Make sure you have the latest ODK installed by running `docker pull obolibrary/odkfull`

To actually run the release, you:

1. Open a command line terminal window and navigate to the src/ontology directory (`cd cob/src/ontology`)
2. Run release pipeline:`sh run.sh make prepare_release -B`. Note that for some ontologies, this process can take up to 90 minutes - especially if there are large ontologies you depend on, like PRO or CHEBI.
3. If everything went well, you should see the following output on your machine: `Release files are now in ../.. - now you should commit, push and make a release on your git hosting site such as GitHub or GitLab`.

This will create all the specified release targets (OBO, OWL, JSON, and the variants, ont-full and ont-base) and copy them into your release directory (the top level of your repo).

## Review the release

1. (Optional) Rough check. This step is frequently skipped, but for the more paranoid among us (like the author of this doc), this is a 3 minute additional effort for some peace of mind. Open the main release (cob.owl) in you favourite development environment (i.e. Protege) and eyeball the hierarchy. We recommend two simple checks: 
    1. Does the very top level of the hierarchy look ok? This means that all new terms have been imported/updated correctly.
    2. Does at least one change that you know should be in this release appear? For example, a new class. This means that the release was actually based on the recent edit file. 
2. Commit your changes to the branch and make a pull request
3. In your GitHub pull request, review the following three files in detail (based on our experience):
    1. `cob.obo` - this reflects a useful subset of the whole ontology (everything that can be covered by OBO format). OBO format has that speaking for it: it is very easy to review!
    2. `cob-base.owl` - this reflects the asserted axioms in your ontology that you have actually edited.
    3. Ideally also take a look at `cob-full.owl`, which may reveal interesting new inferences you did not know about. Note that the diff of this file is sometimes quite large.
4. Like with every pull request, we recommend to always employ a second set of eyes when reviewing a PR!

## Merge the main branch
Once your [CI checks](ContinuousIntegration.md) have passed, and your reviews are completed, you can now merge the branch into your main branch (don't forget to delete the branch afterwards - a big button will appear after the merge is finished).

## Create a GitHub release

1. Go to your releases page on GitHub by navigating to your repository, and then clicking on releases (usually on the right, for example: https://github.com/OBOFoundry/False/releases. Then click "Draft new release"
1. As the tag version you **need to choose the date on which your ontologies were build.** You can find this, for example, by looking at the `cob.obo` file and check the `data-version:` property. The date needs to be prefixed with a `v`, so, for example `v2020-02-06`.
1. You can write whatever you want in the release title, but we typically write the date again. The description underneath should contain a concise list of changes or term additions.
1. Click "Publish release". Done.

