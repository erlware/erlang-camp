-module(create_tables).

-export([init_tables/0, insert_member/3, insert_project/2]).

-record(member, {
          id,
          name
         }).

-record(project, {
          title,
          description
         }).

-record(contributor, {
          member_id,
          project_title
         }).

init_tables() ->
    mnesia:create_table(member,
       [{attributes, record_info(fields, member)}]),
    mnesia:create_table(project,
       [{attributes, record_info(fields, <fixme>)}]),
    mnesia:create_table(contributor,
       [{type, bag}, {attributes, record_info(fields, contributor)}]).

insert_member(Id, Name, ProjectTitles) when ProjectTitles =/= [] ->
    User = #member{id = Id, name = Name},
    Fun = fun() ->
            mnesia:write(User),
            lists:foreach(
              fun(Title) ->
                [#project{title = Title}] = mnesia:read(project, Title),
                mnesia:write(#contributor{member_id = Id,
                                          project_title = Title})
              end,
              ProjectTitles)
          end,
    mnesia:transaction(<fixme>).

insert_project(Title, Description) ->
    mnesia:dirty_write(#project{title = Title,
                                description = Description}).
