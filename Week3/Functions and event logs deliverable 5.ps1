function Get-SystemStartShutdownEvents {
    # Define the Event IDs for system start and shutdown
    $startEventId = 6005
    $shutdownEventId = 6006

    # Retrieve the events from the System log
    $events = Get-WinEvent -LogName System | Where-Object { $_.Id -eq $startEventId -or $_.Id -eq $shutdownEventId }

    # Initialize an array to hold the results
    $results = @()

    foreach ($event in $events) {
        # Determine the event type based on Event ID
        if ($event.Id -eq $startEventId) {
            $eventType = "System Start"
        } elseif ($event.Id -eq $shutdownEventId) {
            $eventType = "System Shutdown"
        }

        # Create a custom object for each event
        $eventObject = [PSCustomObject]@{
            Time  = $event.TimeCreated
            Id    = $event.Id
            Event = $eventType
            User  = "System"
        }

        # Add the custom object to the results array
        $results += $eventObject
    }

    # Return the results
    return $results
}

# Example usage
$systemEvents = Get-SystemStartShutdownEvents
$systemEvents | Format-Table -AutoSize