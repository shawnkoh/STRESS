# CS3217 Problem Set 4

**Name:** Koh Zheng Qiang Shawn

**Matric No:** A0185892L

## Tips
1. CS3217's docs is at https://cs3217.netlify.com. Do visit the docs often, as
   it contains all things relevant to CS3217.
2. A Swiftlint configuration file is provided for you. It is recommended for you
   to use Swiftlint and follow this configuration. We opted in all rules and
   then slowly removed some rules we found unwieldy; as such, if you discover
   any rule that you think should be added/removed, do notify the teaching staff
   and we will consider changing it!

   In addition, keep in mind that, ultimately, this tool is only a guideline;
   some exceptions may be made as long as code quality is not compromised.
3. Do not burn out. Have fun!

## Dev Guide
https://github.com/SanderMertens/ecs-faq
You may put your dev guide either in this section, or in a new file entirely.
You are encouraged to include diagrams where appropriate in order to enhance
your guide.

## Rules of the Game
Please write the rules of your game here. This section should include the
following sub-sections. You can keep the heading format here, and you can add
more headings to explain the rules of your game in a structured manner.
Alternatively, you can rewrite this section in your own style. You may also
write this section in a new file entirely, if you wish.

### Cannon Direction
Please explain how the player moves the cannon.

### Win and Lose Conditions
Please explain how the player wins/loses the game.

## Level Designer Additional Features

### Peg Rotation
Please explain how the player rotates the triangular pegs.

### Peg Resizing
Please explain how the player resizes the pegs.

## Bells and Whistles
Please write all of the additional features that you have implemented so that
your grader can award you credit.

## Tests
If you decide to write how you are going to do your tests instead of writing
actual tests, please write in this section. If you decide to write all of your
tests in code, please delete this section.

## Written Answers

### Reflecting on your Design
> Now that you have integrated the previous parts, comment on your architecture
> in problem sets 2 and 3. Here are some guiding questions:
> - do you think you have designed your code in the previous problem sets well
>   enough?
> - is there any technical debt that you need to clean in this problem set?
> - if you were to redo the entire application, is there anything you would
>   have done differently?

#### Technical Debt: Unity ECS query
here’s my planned design that is loosely based on Unity ECS without their idea of chunks (ive no idea if this is correct btw XD)

1. in a GKScene, register component types
the goal is to allocate a unique index to each component type
componentA = 1, componentB = 2, componentC = 3, …

2. create entities with its components defined.
e.g. entity with componentC, componentA
store the components in an array that matches the ordering in #1 i.e. [componentA, nil, componentC]

check if the GKScene has ever defined such an archetype {componentA, componentC}, and if not, add it to the list of archetypes

add the component array into the archetype {componentA, componentC}

3. in a system, when you query for the entities to iterate, you must specify the component types.

iterate through the list of archetypes to find all archetypes that contains the component types (can possibly use set intersection here)
iterate through each archetype to get the entities needed.
BUT instead of returning an array of entities, return an ordered array of the specified components (based on their ordering in #1)

—
what happens when an entity adds a component?
remove the component array from the current archetype
add the component into the entity’s component array
create the archetype if it does not exist in the GKScene
store the component array into the archetype,

vice versa for removing a component

—
when removing a component array from an archetype, use the trick of replacing the element at the specified index with the last element and nil the last element to avoid O(N) deletion
