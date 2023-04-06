# Solidity-Beginner-3 Notes

---
## View & Pure Function

- The most difference between view & pure function is which can access the blockchain data (state variable)
- View function declares that no state will be changed.
- Pure function declares that no state variable will be changed or read.

    
    
## Function Modifier

- Function Modifier 類似於後端開發的 Middleware，可以於 function 進入前呼叫，主要分為基本、傳入參數、三明治三種使用方式。
1. 此為基本用法，_; 會 invoke 原先 function 裡面的內容
    ```
        modifier whenNotPaused() {
            require(paused == false, "Can not be paused!");
            // Underscore is a special character only used inside a function modifier and it tells Solidity to execute the rest of the code.
            _;
        }
    ```
2. 傳入參數範例
    ```
        modifier checkInput(uint _y) {
            require( _y >= 100, "x must be greater than 100");
            _;
        }
    ```
3. 三明治範例
    ```
        modifier sandwitch() {
            //x + 1 before executed the function
            x += 1;
            // executed the function
            _;
            //x ** 2 after executed the function
            x *= 2;
        }
    ```

## Function visibility

- public - any contract and account can call
- private - only inside the contract that defines the function
- internal- only inside contract that inherits an internal function
- external - only other contracts and accounts can call
- (state variable doesn't have the external visibility)

|  Visibility | Access within contract | Access within derived contract | Access from external contract|
| ------ | ------ | ----- | ----- |
|`public (default)` | Yes | Yes | Yes |
|`external` | No | No | Yes |
|`private` | Yes | No | No |
|`internal` | Yes | Yes | No |

## Selfdestruct

- 此 function 原先可作為兩種功能使用，其一是將所有該合約內的 Storage 清空，並強制將合約內的 Balance 轉出至指定地址，該 function 即將被改成僅會將合約內的 Balance 轉出指定地址，不會有自毀的功能，詳見 [EIP-4758](https://eips.ethereum.org/EIPS/eip-4758)
    ```
    // EIP-4758: Deactivate SELFDESTRUCT
    //The SELFDESTRUCT opcode is renamed to SENDALL, and now only immediately moves all ETH in the account to the target; 
    //it no longer destroys code or storage or alters the nonce
    ```

## Access Control
- 在 Solidity 可以搭配 Modifier 進行 function 呼叫的管控，在管理呼叫者是否為 Admin 或是 Owner 時，避免使用 tx.origin 進行權限的判斷，
否則會出現恆等 true 的問題，應該使用 msg.sender 確保每次呼叫來源的地址是否有足夠權限呼叫。

- msg.sender: 僅記錄呼叫端的帳戶地址，因此可以是 EOA 也可以是合約帳戶
- tx.origin: 代表整個 transaction 過程中第一個呼叫智能合約的帳戶地址，一定會是 Externally-owned account