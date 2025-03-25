function nc2mat(theNetCDF, theMat)
2	
3	% nc2mat -- Convert NetCDF file to mat-file.
4	%  nc2mat('theNetCDF', 'theMat') creates 'theMat' file
5	%   from the contents of 'theNetCDF' file.  Dimensions,
6	%   variables, and attributes are named with prefixes
7	%   of 'D_', 'V_', and 'A_', respectively.
8	%   Global-attributes are prefixed by 'G'.  Names
9	%   that are not legal Matlab names are repaired with
10	%   '_' (underscore) for each invalid character, then
11	%   truncated to 31 characters.  Repaired names are not
12	%   checked for uniqueness.
13	%
14	%   See "help whos" and "help load" for information
15	%   about reading the contents of the mat-file.
16	 
17	% Copyright (C) 2001 Dr. Charles R. Denham, ZYDECO.
18	%  All Rights Reserved.
19	%   Disclosure without explicit written consent from the
20	%    copyright owner does not constitute publication.
21	 
22	% Version of 31-May-2001 14:07:35.
23	% Updated    31-May-2001 15:17:43.
24	
25	if nargin < 1, help(mfilename), theNetCDF = '*'; end
26	if nargin < 2, theMat = '*'; end
27	
28	if any(theNetCDF == '*')
29	        [p, f] = uigetfile(theNetCDF, 'Select a NetCDF File');
30	        if ~any(f), return, end
31	        if p(end) ~= filesep, p(end+1) = filesep; end
32	        theNetCDF = [p f];
33	end
34	
35	if any(theMat == '*')
36	        [p, f] = uiputfile(theMat, 'Save As Mat File');
37	        if ~any(f), return, end
38	        if p(end) ~= filesep, p(end+1) = filesep; end
39	        theMat = [p f];
40	end
41	
42	nc = netcdf(theNetCDF, 'nowrite');
43	if isempty(nc), return, end
44	
45	Created_By = [mfilename '(''' theNetCDF ''', ''' theMat ''')   % ' datestr(now)];
46	save(theMat, 'Created_By')
47	
48	% Global attributes.
49	
50	gatts = att(nc);
51	for i = 1:length(gatts)
52	        gattname = ['G_' name(gatts{i})];
53	        gattname = repair_matlab_name(gattname);
54	        gattvalue = gatts{i}(:);
55	        eval([gattname ' = gattvalue;'])
56	        save(theMat, gattname, '-append')
57	end
58	
59	% Dimensions.
60	
61	dims = dim(nc);
62	for i = 1:length(dims)
63	        dimname = name(dims{i});
64	        dimname = ['D_' dimname];
65	        dimname = repair_matlab_name(dimname);
66	        dimlen = ncsize(dims{i});
67	        eval([dimname ' = dimlen;'])
68	        save(theMat, dimname, '-append')
69	        clear(dimname)
70	end
71	
72	% Variables and attributes.
73	
74	vars = var(nc);
75	for i = 1:length(vars)
76	        varname = ['V_' name(vars{i})];
77	        varname = repair_matlab_name(varname);
78	        atts = att(vars{i});
79	        for j = 1:length(atts)
80	                attname = [varname '_A_' name(atts{j})];
81	                attname = repair_matlab_name(attname);
82	                attvalue = atts{j}(:);
83	                eval([attname ' = attvalue;'])
84	                save(theMat, attname, '-append')
85	        end
86	        varvalue = vars{i}(:);
87	        eval([varname ' = varvalue;'])
88	        save(theMat, varname, '-append')
89	end
90	
91	nc = close(nc);
92	
93	disp(' ')
94	disp([' ## Contents of "' theMat '":'])
95	disp(' ')
96	
97	whos('-file', theMat)
98	
99	function y = repair_matlab_name(x, replacement)
100	
101	% repair_matlab_name -- Convert to valid Matlab name.
102	%  repair_matlab_name('theName') converts 'theName' to
103	%   a valid Matlab name by replacing invalid
104	%   characters with '_' (underscore).  Names
105	%   are then truncated to 31 characters.
106	%  repair_name('theName', 'c') uses 'c' as the
107	%   replacement character.
108	
109	if nargin < 2, replacement = '_'; end
110	
111	f = (x == '_') | ...
112	                (x >= 'A' & x <= 'Z') | ...
113	                (x >= 'a' & x <= 'z') | ...
114	                (x >= '0' & x <= '9');
115	
116	if any(x(1) == ['_0123456789'])
117	        f(1) = ~~0;
118	end
119	
120	y = x;
121	
122	if any(~f)
123	        y(~f) = replacement;
124	        if ~f(1), y = ['x' y]; end
125	end
126	
127	if length(y) > 31, y = y(1:31); end