Feature: Good beer point

    Scenario: Checking that beer point exist
        When Looking at home page
        Then We see beer point name
        And We see "Beer Point" in title

    Scenario: Amazing beer choices
        When Looking at home page
        Then We see beer styles
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
    Scenario: Beer point work with non ASCII characters in beer style name
        When Looking at home page
        Then We see beer styles
            | type          |
            | code żeś      |
            | code się      |

    @wip @beerdesc
    Scenario Outline: Beer description colour depend on number of pints
        Given Beer point
        When Number of pints for a beer is <relation> 0
        Then The beer description is <colour>
        Examples: Basic beer description
            | relation      | colour    |
            | equal         | red       |
            | greater than  | not red   |

