Feature: Good beer

    Scenario: Checking that beer point exist
        When Looking at home page
        Then We see beer point name
        And We see Beer Point in title

    Scenario: Amazing beer choices
        When Looking at home page
        Then We see beer style types
            | type          |
            | brown ale     |
            | pale ale      |
            | mild ale      |
            | belgian ale   |
            | stout         |
            | lambic        |
            | wheat         |
            | pale lager    |
            | dark lager    |

    @encode 
    Scenario: Encode beer style
        When Looking at home page
        Then We see beer style types
            | type          |
            | code żeś      |
            | code się      |

    @wip @beerdesc
    Scenario Outline: Beer description colour
        Given Beer points
        When Number of pints for a beer is <relation> 0
        Then The Beer description is <colour>
        Examples: Beer desc
            | relation      | colour    |
            | equal         | red       |
            | greater than  | not red   |
