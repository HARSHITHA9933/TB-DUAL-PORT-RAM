# TB-DUAL-PORT-RAM
Here’s the description:

1. Design:  
   - Implements the dual-port RAM functionality, allowing independent and simultaneous read and write operations.  
   - Includes control signals (`read_enable`, `write_enable`), address buses, and data buses for each port.  

2. Interface:  
   - Centralizes the connection between the DUT and testbench components by encapsulating all signals required for the RAM's operation.  
   - Simplifies signal management and makes the testbench modular.

3. Transaction:  
   - A class object that represents a single RAM operation (read or write).  
   - Includes attributes such as address, data, and optional byte_enable.  
   - Allows constraint-based randomization to generate diverse test scenarios.

4. Read Driver:  
   - Drives the inputs needed for read operations, such as the address and control signals, using the transaction object.  
   - Ensures transactions are applied to the DUT in a synchronized manner.

5. Write Driver:  
   - Similar to the read driver but focuses on write operations.  
   - Drives the address, data, and write control signals into the DUT based on the transaction object.

6. Read Monitor:  
   - Passively observes the outputs from the read port of the DUT.  
   - Captures data read from the RAM and forwards it to the scoreboard for validation.  
   - Ensures read operations produce consistent and valid data.

7. Write Monitor:  
   - Passively observes write operations, capturing write data and addresses.  
   - Tracks all writes issued to the DUT for reference and debugging purposes.  
   - Validates that write operations occur correctly according to the input stimulus.

8. Reference Model:  
   - A behavioral model that mimics the ideal behavior of the dual-port RAM.  
   - Keeps an internal memory map to simulate the expected data based on observed writes.  
   - Generates expected outputs for read operations.

9. Scoreboard:  
   - The primary validation unit that compares actual read outputs from the DUT with expected outputs from the reference model.  
   - Logs mismatches for debugging, detailing the transaction, expected data, and actual results.

10. Environment:  
    - Integrates the drivers, monitors, reference model, and scoreboard into a cohesive testbench.  
    - Manages the flow of transactions and ensures proper interaction between components.

11. Testbench Top Module:  
    - Connects the DUT and testbench components.  
    - Sets up clocks, resets, and instantiates the environment.  
    - Handles initialization and simulation control.

12. Randomization & Constraints:  
    - Generates diverse test scenarios by randomizing transaction attributes like address and data.  
    - Uses constraints to ensure transactions remain valid within the defined test space.

This streamlined structure provides efficient and thorough verification of your dual-port RAM design.
