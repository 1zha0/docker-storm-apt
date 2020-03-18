schemaVersion: "2.0.0"

commandTests:
  - name: "storm command is registered."
    command: "storm"
    args: ["version"]
    expectedOutput: [".*apache-storm-%STORM_VERSION%.*"]
