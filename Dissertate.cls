% -------------------------------------------------------------------
%  @LaTeX-class-file{
%     filename        = "Dissertate.cls",
%     version         = "2.0modified",
%     date            = "25 March 2014",
%     codetable       = "ISO/ASCII",
%     keywords        = "LaTeX, Dissertate",
%     supported       = "Send email to suchow@post.harvard.edu.",
%     docstring       = "Class for a dissertation."
% --------------------------------------------------------------------

% ----------------------------------------------------
% Modified significantly by Martin Forsythe July, 2015
% ----------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Dissertate}
\LoadClass[11pt, twoside, letterpaper]{book}

% Text layout.
\RequirePackage[ margin=1.25in, letterpaper]{geometry}  %previously width=5.75in
\usepackage{ragged2e}
%\RaggedRight  % FOR WHATEVER REASON THIS MESSES UP LINEBREAKING
\raggedright % THIS is a better way to get left-justified text
\parindent 11pt
\RequirePackage{setspace}
\RequirePackage{verbatim}
\RequirePackage{graphicx}
\RequirePackage[usenames,dvipsnames,svgnames,table]{xcolor}

% Fonts.
\usepackage{lmodern}     % use Latin Modern fonts: updated versions of Computer Modern
\usepackage[T1]{fontenc} % Use T1 font encoding to support additional non-English characters
\usepackage{textcomp}    % enable use of \textcent command without interferring with bold-math the way that waysym does
\RequirePackage[version=3]{mhchem} % chemistry package provides \ce{}
\RequirePackage{amsmath,amsfonts,amssymb} % ams math
\RequirePackage{bm}   % bold math package (better than \boldsymbol)
\RequirePackage{bbm} % blackboard bold math (better than \Bbb)
\RequirePackage{calligra} % curly script
\RequirePackage[mathscr]{euscript} % alternative curly script
\RequirePackage{pifont}  % circled numbers etc.
\RequirePackage{braket} % quantum stuff

% Figures & tables
\RequirePackage{float}  % enables some tricky spacing of figures
\RequirePackage[percent]{overpic} % allow latex to write stuff on top of figures
\RequirePackage{epstopdf} % EPS graphics
\setlength{\fboxrule}{0.7pt}   % set thicker figure box: default is 0.4pt
\setlength\arrayrulewidth{1.1pt}  % use slightly thicker rules in tables
\RequirePackage{booktabs} % better rules for tables:  \toprule, \midrule, \bottomrule
\RequirePackage{multirow}  % allow row spanning
\RequirePackage{longtable} % allow long tables to break across pages
\RequirePackage{setspace} % package that allows setting singlespace mode
\RequirePackage{array}       % enable columns that wrap to certain width using the following commands:
\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}} % provides new column type L{Xcm} that wrap text to Xcm
\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}    % provides new column type C{Xcm} that wrap text to Xcm
\newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}   % provides new column type R{Xcm} that wrap text to Xcm


%  Fixing widows and orphans,
\widowpenalty=300
\clubpenalty=300

% Captions:
\RequirePackage[labelfont={bf,sf,footnotesize,singlespacing}, % Use sans-serif font  ## CHECK
                textfont={sf,footnotesize,singlespacing},                   % Use sans-serif font  ## CHECK
                justification={justified,RaggedRight},
                singlelinecheck=false,
                margin=0pt,
                figurewithin=chapter,
                tablewithin=chapter]{caption}

% Footnotes:
\renewcommand{\thefootnote}{\fnsymbol{footnote}}  % ## POSSIBLY COMMENT OUT

% Headings and headers.
\RequirePackage{fancyhdr}
\RequirePackage[tiny, md, sc]{titlesec}
\setlength{\headheight}{15pt}
%\pagestyle{plain}  % ## CHECK
\RequirePackage{titling}

% Front matter.
\setcounter{tocdepth}{2} % this defaults to 1,
\setcounter{secnumdepth}{3} % do number sub-sub-sections
\usepackage[titles]{tocloft}
\usepackage[titletoc]{appendix}
\renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftchapfont}{\normalsize \scshape}
\renewcommand\listfigurename{Listing of figures}
\renewcommand\listtablename{Listing of tables}

%% Endmatter
\renewcommand{\setthesection}{\arabic{chapter}.A\arabic{section}}

% References
\renewcommand\bibname{References}
\RequirePackage[super,comma,numbers,sort&compress]{natbib}
%\renewcommand{\bibnumfmt}[1]{[#1]} % this bib formatting is already included when natmove is loaded. uncomment if you don't use natmove
\RequirePackage{natmove} % move punctuation around citations

% Chapter header formatting:
\RequirePackage[palatino]{quotchap}
\renewcommand*{\chapterheadstartvskip}{\vspace{0cm}}  % was * -0.5\baselineskip previously
\renewcommand*{\chapterheadendvskip}{\vspace{ 0.8\baselineskip}} % was 1.3\baselineskip previously

%% An environment for paragraph-style section.
%\providecommand\newthought[1]{%
%   \addvspace{1.0\baselineskip plus 0.5ex minus 0.2ex}%
%   \noindent\textsc{#1}%
%}

% Align reference numbers so that they do not cause an indent.
\newlength\mybibindent
\setlength\mybibindent{0pt}
\renewenvironment{thebibliography}[1]
    {\chapter*{\bibname}%
     \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
     \list{\@biblabel{\@arabic\c@enumiv}}
          {\settowidth\labelwidth{\@biblabel{999}}
           \leftmargin\labelwidth
            \advance\leftmargin\dimexpr\labelsep+\mybibindent\relax\itemindent-\mybibindent
           \@openbib@code
           \usecounter{enumiv}
           \let\p@enumiv\@empty
           \renewcommand\theenumiv{\@arabic\c@enumiv}}
     \sloppy
     \clubpenalty4000
     \@clubpenalty \clubpenalty
     \widowpenalty4000%
     \sfcode`\.\@m}
    {\def\@noitemerr
      {\@latex@warning{Empty `thebibliography' environment}}
     \endlist}

% Some definitions.
\def\degreeyear#1{\gdef\@degreeyear{#1}}
\def\degreemonth#1{\gdef\@degreemonth{#1}}
\def\degree#1{\gdef\@degree{#1}}
\def\advisor#1{\gdef\@advisor{#1}}
\def\department#1{\gdef\@department{#1}}
\def\field#1{\gdef\@field{#1}}
\def\university#1{\gdef\@university{#1}}
\def\universitycity#1{\gdef\@universitycity{#1}}
\def\universitystate#1{\gdef\@universitystate{#1}}
\def\programname#1{\gdef\@programname{#1}}
\def\pdOneName#1{\gdef\@pdOneName{#1}}
\def\pdOneSchool#1{\gdef\@pdOneSchool{#1}}
\def\pdOneYear#1{\gdef\@pdOneYear{#1}}
\def\pdTwoName#1{\gdef\@pdTwoName{#1}}
\def\pdTwoSchool#1{\gdef\@pdTwoSchool{#1}}
\def\pdTwoYear#1{\gdef\@pdTwoYear{#1}}
\def\pdThreeName#1{\gdef\@pdThreeName{#1}}
\def\pdThreeSchool#1{\gdef\@pdThreeSchool{#1}}
\def\pdThreeYear#1{\gdef\@pdThreeYear{#1}}

% School name and location
\university{Harvard University}
\universitycity{Cambridge}
\universitystate{Massachusetts}

% School color found from university's graphic identity site:
% http://www.seas.harvard.edu/communications/identity-guidelines/color-palettes
% http://isites.harvard.edu/icb/icb.do?keyword=k75408&pageid=icb.page392732
\definecolor{SchoolColor}{rgb}{0.6471, 0.1098, 0.1882} % Crimson
\definecolor{crimson}{rgb}{0.6471, 0.1098, 0.1882}
\definecolor{chaptergrey}{rgb}{0.6471, 0.1098,  0.1882} % make the chapter numbers Crimson too
\definecolor{ink}{rgb}{                0.1176,  0.1176,  0.1176}
\definecolor{slate}{rgb}{             0.5373, 0.5882, 0.6275}


%% We load hyperref last because one of the packages above causes a minor conflict with footnote definitions
\usepackage{hyperref}
\hypersetup{
    colorlinks=false,  % turn off link coloring
    citecolor=SchoolColor,
    filecolor=black,
    linkcolor=black,
    urlcolor=SchoolColor,
}


%% --  Formatting guidelines found in: --
% http://www.gsas.harvard.edu/publications/form_of_the_phd_dissertation.php

% The front matter:
\renewcommand{\frontmatter}{
	\input{frontmatter/personalize}
	\maketitle
	\copyrightpage
	%\setstretch{1.2}
	\abstractpage
	% TOC & list of figures may be single spaced
	\let\cleardoublepage\relax
	\singlespacing
	\tableofcontents
    \newpage
    \listoffigures
    \newpage
	\doublespacing      % Return to double spacing after

	% the remaining front mater does not have an order specified by the Harvard formatting guidelines:
	\dedicationpage     % optional
	\acknowledgments % mandatory
	\authorlist               % optional

	\doublespacing      % definitely return to double spacing for the main text
	\pagestyle{maintextstyle} % initiate the desired pagestyle for the rest
	\pagenumbering{arabic}	\setcounter{page}{1}  % Start the main text at page #1
}


%% general page style:
\fancypagestyle{maintextstyle}{
	\fancyhf{} % clear all headers
	\fancyhead[LO]{\nouppercase\leftmark}
	\fancyhead[RE]{\nouppercase\rightmark}
	\renewcommand{\headrulewidth}{1pt}
	\fancyfoot[C]{\thepage}
}

\newcommand\semiHuge{\@setfontsize\semiHuge{22.72}{27.38}}

% Formatting of the title page:
\renewcommand{\maketitle}{
	\thispagestyle{empty}
	\vspace*{\fill}
	\vspace{100pt}
	\begin{center}
%	\Huge \textcolor{SchoolColor}{\thetitle} \normalsize \\   % feel free to use the larger title size, for a long title it may break onto too many lines
        \semiHuge \textcolor{SchoolColor}{\thetitle} \normalsize \\
	\vspace{100pt}
	\textsc{a dissertation presented \\ by\\
	\theauthor\\ to\\ The Department of \@department\\
	\vspace{11pt}
	in partial fulfillment of the requirements\\
	for the degree of\\ \@degree\\
	in the subject of\\ \@field\\
	\vspace{11pt}
	\@university\\ \@universitycity, \@universitystate\\
	\@degreemonth\ \@degreeyear}
	\end{center} \vspace*{\fill}
}

% Formatting of the copyright page:
\newcommand{\copyrightpage}{
	\newpage
	\thispagestyle{empty}
	\vspace*{\fill}
	\scshape \noindent \small \copyright \small \@degreeyear  \hspace{3pt}-- \theauthor \\
	\noindent all rights reserved.
	\vspace*{\fill}
	\normalfont %\newpage\rm % ### CHECK
}

% Formatting of the abstract page:
\fancypagestyle{abstractstyle}{
	\pagenumbering{roman} \setcounter{page}{3}  % ABSTRACT MUST BE NUMBERED iii
	\lhead{Dissertation Advisor: Professor \@advisor} \rhead{\@author}
	\renewcommand{\headrulewidth}{0pt}
	\renewcommand{\footrulewidth}{0pt}}

\newcommand{\abstractpage}{
	\newpage
	\doublespacing    % ABSTRACT MUST BE DOUBLE SPACED
	\thispagestyle{abstractstyle}
	\renewcommand{\headrulewidth}{0.0pt}
	\vspace*{35pt}
	\begin{center}
	\Large \textcolor{SchoolColor}{\@title} \normalsize \\
	\vspace*{20pt}
	\scshape Abstract \\ \normalfont
	\end{center}
	\input{frontmatter/abstract}
	\vspace*{\fill}
	\newpage\normalfont
	\pagestyle{plain}
}

% Formatting of the dedication page:
\newcommand{\dedicationpage}{
	\newpage \thispagestyle{plain}  \vspace*{\fill} % ### CHECK
	\pagenumbering{roman} \setcounter{page}{6} % ### CHECK THIS NUMBERING
	\noindent \input{frontmatter/dedication}
	\vspace*{\fill} \newpage \normalfont %\rm % ### CHECK
}

% Formatting of the acknowledgements page:
\newcommand{\acknowledgments}{
	\pagenumbering{roman} \setcounter{page}{7}  % ### CHECK THIS NUMBERING
	\chapter*{Acknowledgments}
	\noindent \input{frontmatter/acknowledgments}
	\vspace*{\fill}  \newpage\normalfont % \rm % ### CHECK
}

% Formatting of the authorlist page
\newcommand{\authorlist}{
        \pagenumbering{roman} \setcounter{page}{9} % ### CHECK THIS NUMBERING
        \chapter*{Further Acknowledgements by Chapter}
        \noindent \input{frontmatter/authorlist}
        \vspace*{\fill}   \newpage\normalfont % \rm % ### CHECK
}

% Formatting of clearpage. Author: Joseph Goodknight (github:jgoodknight)
\renewcommand\part{%
    \clearpage
  \thispagestyle{plain}%
  \null\vfil
  \secdef\@part\@spart}
\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >-2\relax
      \refstepcounter{part}%
      \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
    \else
      \addcontentsline{toc}{part}{#1}%
    \fi
    \markboth{}{}%
    {\centering
     \interlinepenalty \@M
     \normalfont
     \ifnum \c@secnumdepth >-2\relax
       \huge\bfseries \partname\nobreakspace\thepart
       \par
       \vskip 20\p@
     \fi
     \Huge \bfseries #2\par}%
    \@endpart}
\def\@spart#1{%
    {\centering
     \interlinepenalty \@M
     \normalfont
     \Huge \bfseries #1\par}%
    \@endpart}

\def\@endpart{\vfil\newpage
              \if@twoside
               \if@openright

            \vspace*{\fill}
            \hfill
            \begin{center}
            This page intentionally left blank.
            \end{center}
            \vspace{\fill}
            \thispagestyle{plain}
                \newpage
               \fi
              \fi
              \if@tempswa
                \twocolumn
              \fi}

