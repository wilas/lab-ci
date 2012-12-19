Feature: Good beer

    Scenario: Checking that beer point exist
        When Looking at home page
        Then We see beer point name
        And We see Beer Point in title
     
    Scenario Outline: Amazing beer choices
        When Looking at home page
        Then We see <type> beer style        
        Examples: BeerStyle
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
    Scenario Outline: Encode beer style
        When Looking at home page
        Then We see <type> beer style
        Examples: BeerEncode
            | type          |
            | code żeś      |
            | code się      |
 
    @wip @beerdesc
    Scenario: Beer shortage colour
        Given Beer points
        When Number of pints for a beer is "equal" 0
        Then The Beer description is "red"
    
    @wip @beerdesc
    Scenario: Beer description colour
        Given Beer points
        When Number of pints for a beer is "greater than" 0
        Then The Beer description is "not red"

