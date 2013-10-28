%% chkarg
% Throw an exception if the argument is |false|.

%%% Syntax
%  chkarg(truth, errmsg, varargin)

%%% Description
% |chkarg(truth, errmsg, varargin)| throws an exception of |truth| is |false|.
% |errmsg| is an error message embedded in the exception.  The error message
% can be generated by formatting additional arguments |varargin|; in this case,
% |errmsg| should be a format string.

%%% Example
%   chkarg(isreal(3+4i), '3+4i is not real.');

function chkarg(truth, errmsg, varargin)

errmsg = sprintf(errmsg, varargin{:});

if ~truth
	exception = MException('Maxwell:argChk', 'Wrong argument: %s', errmsg);
	throwAsCaller(exception);
end
