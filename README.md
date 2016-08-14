# dissertation_template
Dissertation Template for Harvard

This template is constructed such that you can take your current papers and make them into dissertation chapters quickly and easily. I actually wrote so that while I was finishing up two publications while also writing my dissertation. Instead of copying and pasting across from my paper into my dissertation tex file, I went ahead and broke the elements of the paper up into `abstract.tex` and `text.tex`, corresponding to the abstract and paper text. I then had tex file to make the 2-column journal version and a tex file to make the dissertation version. This can be seen by looking at `paper1/paper1.tex` and `paper1/disedit.tex`. Running make in `paper1`, makes the journal version, and running make in the root folder makes the entire dissertation.

In my recommendation, each paper should get its own folder. In that folder, the body of the paper should be broken out into `text.tex`, the abstract into `abstract.tex`, and the citations in `disedit.tex` should be fixed. It's actually quite easy to use the paper format detailed above while writing your papers, and makes throwing together the meat of a dissertation quite easy. 

Of course, I did not write all of this. Much of this thesis template was handed down to me from Jacob Sanders, Ryan Babbush, and others. There are many references in the various latex templates to credit them and their work.

The python3 script bibliography/bib_check.py will check your bibliography for missing DOIs, duplicate entries, stray unicode characters, and journal abbreviations. Invoke it by running

python3 bib_check.py myBibliographyHere.bib 

at terminal. 
