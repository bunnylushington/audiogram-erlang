-module(audiogram).
-export([ 
          template/0
        , audiogram/0
        , audiogram/1
        , audiogram/2
        ]).

-define(PLACEHOLDER, "audiogram_data").

-define(MIN_Y, 400).  % origin of the Y axis
-define(MAX_Y, 25).   % top Y axis tick
-define(MIN_X, 80).   % origin of the X axis
-define(MAX_X, 640).  % rightmost X axis tick

-define(MIN_Y_VALUE, 140). % Y axis label at origin
-define(MAX_Y_VALUE, -10). % Y axis label at top of Y axis

-define(Y_AXIS_OFFSET, 25).  % pixels between Y axis ticks
-define(X_AXIS_OFFSET, 80).  % pixels between x axis ticks


audiogram() ->
  audiogram([], template()).

audiogram(Data) ->
  audiogram(Data, template()).

audiogram(Data, Template) when is_list(Data) -> 
  audiogram(list_to_binary(Data), Template);

audiogram(Data, Template) ->
  MarkHTML = evaluate_audiogram_data(Data),
  bbmustache:render(Template, #{ ?PLACEHOLDER => MarkHTML }).

template() -> 
  template(filename:join([template_directory(), template_filename()])).

template(File) -> 
  {ok, Template} = file:read_file(File),
  Template.

template_directory() -> code:priv_dir(audiogram).
template_filename() -> "graph.html".


evaluate_audiogram_data([]) ->  [];
evaluate_audiogram_data(Data) ->
  generate_marks(jsx:decode(Data, [{labels,atom}, return_maps])).

generate_marks(#{ audiograms := Audiograms }) ->
  generate_marks(Audiograms, []);
generate_marks(_) -> [].

%% Do this for each audiogram specified.
generate_marks([], Acc) -> 
  Acc;
generate_marks([H|T], Acc) ->
  Conduction = binary_to_existing_atom(maps:get(conduction, H), latin1),
  Ear = binary_to_existing_atom(maps:get(ear, H), latin1),
  Data = maps:get(data, H),
  NewMarks = marks_from_data(Conduction, Ear, Data),
  generate_marks(T, [NewMarks | Acc]).

%% Do this for each data point.
marks_from_data(Conduction, Ear, Data) -> 
  marks_from_data(Conduction, Ear, lists:sort(fun freqsort/2, Data), [], []).

freqsort(M1, M2) ->  maps:get(f, M1) >= maps:get(f, M2).

marks_from_data(_, _, [], _, Acc) -> Acc;
marks_from_data(Conduction, Ear, [Data|T], LastMark, Acc) -> 
  Symbol = mark(Ear, Conduction, Data),
  X = x(Data),
  Y = y(Data),
  NewMark = io_lib:format(mark_format(), [X, Y, Ear, Symbol]),
  Line = line(LastMark, X, Y, Ear),
  marks_from_data(Conduction, Ear, T, 
                  [X, Y],
                  [iolist_to_binary([NewMark, Line]) | Acc]).

line([], _, _, _) -> [];
line([LX, LY], X, Y, Ear) -> 
  io_lib:format(line_format(), [(LX-5), LY, (X+5), Y, Ear]).

mark_format() -> "<text x=\"~p\" y=\"~p\" class=\"mark ~p\">~s</text>".
line_format() -> 
  "<line x1=\"~p\" y1=\"~p\" x2=\"~p\" y2=\"~p\" class=\"~p\" />".

%% Determine what mark character to use.
mark(Ear, Conduction, Data) when is_map(Data) ->
  Masked = case maps:get(m, Data, false) of
             false -> unmasked;
             true  -> masked
           end,
  mark(Ear, Conduction, Masked);

mark(right, air,  unmasked) -> "&#9675";  % circle
mark(right, air,  masked)   -> "&#9651";  % triangle
mark(left,  air,  unmasked) -> "&#10005"; % X
mark(left,  air,  masked)   -> "&#9633";  % square
mark(right, bone, unmasked) -> "&lt;";    % <
mark(right, bone, masked)   -> "&#8847";  % [
mark(left,  bone, unmasked) -> "&gt;";    % >
mark(left,  bone, masked)   -> "&#8848".  % ]

%% Given a frequency in Hz, return the X coordinate of the mark.
x(Data) when is_map(Data) -> x(maps:get(f, Data));
x(0.125) -> 80;
x( 0.25) -> 160;
x(  0.5) -> 240;
x( 0.75) -> 280;
x(    1) -> 320;
x(  1.5) -> 360;
x(    2) -> 400;
x(    3) -> 440;
x(    4) -> 480;
x(    6) -> 520;
x(    8) -> 560;
x(   12) -> 600;
x(   16) -> 640.

%% Given a level in dB, return the Y coordinate of the mark.
y(Data) when is_map(Data) -> y(maps:get(db, Data));
y(DB) -> 
  ?MAX_Y + (((DB / 10) + 1) * ?Y_AXIS_OFFSET).

