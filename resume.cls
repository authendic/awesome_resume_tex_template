% 定主一个类模板(.cls) 
\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{resume}[2015/05/25 An elegant Résumé class]

% \LoadClass[a4paper, 11pt]{article}
\LoadClass[11pt]{ctexart}
\RequirePackage{fontspec}
\pagestyle{plain}
% Main document font


% 不显示页码
%\pagenumbering{gobble}
% 行距倍数
\renewcommand{\baselinestretch}{0.5}

% 添加首行缩进，两个字符
\RequirePackage{indentfirst}
\setlength{\parindent}{2em}
% some general improvements, defines the XeTeX logo
\RequirePackage{xltxtra}
% use xifthen
\RequirePackage{xifthen}
% use progress bar for skill
%\RequirePackage{progressbar}
% use hyperlink for email and url
%\RequirePackage[colorlinks,linkcolor=red,anchorcolor=blue,citecolor=green,CJKbookmarks=True]{hyperref}

\RequirePackage{url}
\urlstyle{tt}
% use fontawesome
\RequirePackage{fontawesome}
% use xcolor for customizing color
%\RequirePackage[usenames,dvipsnames]{xcolor}
% loading fonts

\RequirePackage[
	a4paper,
	left=0.8in,
	right=0.8in,
	top=0.70in,
	bottom=0.55in,
	nohead
]{geometry}

\RequirePackage{titlesec}
\RequirePackage{enumitem}
\setlist{noitemsep} % removes spacing from items but leaves space around the whole list
%\setlist{nosep} % removes all vertical spacing within and around the list
\setlist[itemize]{topsep=0.25em, leftmargin=1.5pc}
\setlist[enumerate]{topsep=0.25em, leftmargin=1.5pc}
\RequirePackage[super]{nth}

\titleformat{\section}         % Customise the \section command 
  %{\Large\scshape\raggedright} % Make the \section headers large (\Large),
  {\Large\raggedright} % Make the \section headers large (\Large),
                               % small capitals (\scshape) and left aligned (\raggedright)
  {}{0.5em}                      % Can be used to give a prefix to all sections, like 'Section ...'
  {}                           % Can be used to insert code before the heading
  [\titlerule]                 % Inserts a horizontal line after the heading

\titleformat{\subsection} {}{\faCheck }{0em}{}

\titlespacing*{\section}{0.3em}{1.8\baselineskip}{1.8 \baselineskip}

\titleformat{\subsection}
  {\large\raggedright}
  {}{0em}
  {}
\titlespacing*{\subsection}{0.3em}{*1.8}{*1.8}

\newcommand{\datedsection}[2]{%
  \section[#1]{#1 \hfill #2}%
}
\newcommand{\datedsubsection}[2]{%
  %\subsection[#1]{#1 \hfill #2}%
  \subsection{#1 \hfill #2}%
}
\newcommand{\datedline}[2]{%
  {\par #1 \hfill #2 \par}%
}

% defines progress bar with text
% usage: \pbar[3][width]{Text}{percentage}
%\newcommand{\pbar}[3][10em]{{#2}\ 
%  \progressbar[heightr=1, width=#1, borderwidth=0pt, roundnessr=0.45, filledcolor=green!40, subdivisions=1]{#3}
%}


% 重新定义命令 \title{<t>}
% 命令的作用是定义一个全局变量 \IHEP@valaue@title 的值为 <t>
% 定义命令的格式是[]指定参数个数， 在{}内是动作， #1代表第一个参数
%\renewcommand\title[1]{\def\IHEP@value@title{#1}}
\newcommand*{\name}[2]{\def\@firstname{#1}\def\@lastname{#2}}
\newcommand*{\birthday}[1]{\def\@birthday{#1}}
\newcommand*{\objective}[1]{\def\@objective{#1}}
\newcommand*{\email}[1]{\def\@email{#1}}
\newcommand*{\phone}[1]{\def\@phone{#1}}
\newcommand*{\homepage}[1]{\def\@homepage{#1}}
\newcommand*{\wechat}[1]{\def\@wechat{#1}}
\def\@gender@symbol{\faMars}
\newcommand*{\gendermale}[0]{\def\@gender@symbol{\faMars}}
\newcommand*{\genderfemale}[0]{\def\@gender@symbol{\faVenus}}

\newcommand\makecvtitle{%
      \begin{center}
      \underline{\Huge{\@lastname\@firstname } } { \@gender@symbol }
        \vskip 20pt
      \ifthenelse{\isundefined{\@objective}}{}{{\bf 求职意向：}\@objective}
        \vskip 8pt
      \ifthenelse{\isundefined{\@birthday}}{}{ \faBirthdayCake\ \@birthday }
      \ifthenelse{\isundefined{\@phone}}{}{ \faMobilePhone\ \@phone}
      \ifthenelse{\isundefined{\@email}}{}{ \faEnvelopeO\ \@email}
      \ifthenelse{\isundefined{\@homepage}}{}{ \faChrome\ \@homepage}
      \ifthenelse{\isundefined{\@wechat}}{}{ \faWechat\ \@wechat}
      \end{center}
}

