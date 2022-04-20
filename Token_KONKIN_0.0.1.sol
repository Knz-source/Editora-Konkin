// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.13;

interface IERC20 {
        function totalSupply() external view returns (uint256);
        function balanceOf(address account) external view returns (uint256);
        function transfer(address recipient, uint256 amount) external returns (bool);
        function allowance(address owner, address spender) external view returns (uint256);
        function approve(address spender, uint256 amount) external returns (bool);
        function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
        event Transfer(address indexed from, address indexed to, uint256 value);
        event Approval(address indexed owner, address indexed spender, uint256 value);
}

abstract contract ReentrancyGuard {
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;
    uint256 private _status;
    constructor () {
        _status = _NOT_ENTERED;
    }

    modifier nonReentrant() {
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");
        _status = _ENTERED;
        _;
        _status = _NOT_ENTERED;
    }
}

abstract contract Context {
        function _msgSender() internal view virtual returns (address) {return msg.sender;}
        function _msgData() internal view virtual returns (bytes memory) {this;return msg.data;}
}

library Address {

    function isContract(address account) internal view returns (bool) {
        return account.code.length > 0;
    }

    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        (bool success, bytes memory returndata) = target.call{value: value}(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }

    function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        (bool success, bytes memory returndata) = target.delegatecall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

contract Ownable is Context {
        address private _owner;
        address private _previousOwner;
        uint256 private _lockTime;
        event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
        constructor () {
                address msgSender = _msgSender();
                _owner = msgSender;
                emit OwnershipTransferred(address(0), msgSender);
        }
        function owner() public view returns (address) {return _owner;}
        modifier onlyOwner() {require(_owner == _msgSender(), "Ownable: caller is not the owner");_;}
        function renounceOwnership() public virtual onlyOwner {emit OwnershipTransferred(_owner, address(0)); _owner = address(0);}
        function transferOwnership(address newOwner) public virtual onlyOwner {
                require(newOwner != address(0), "Ownable: new owner is the zero address");
                emit OwnershipTransferred(_owner, newOwner);
                _owner = newOwner;
        }
        function geUnlockTime() public view returns (uint256) {return _lockTime;}
        function lock(uint256 time) public virtual onlyOwner {
                _previousOwner = _owner;
                _owner = address(0x1337);
                _lockTime = block.timestamp + time;
                emit OwnershipTransferred(_owner, address(0x1337));
        }

        function unlock() public virtual {
                require(_previousOwner == msg.sender, "You don't have permission to unlock");
                require(block.timestamp > _lockTime , "Contract is locked until 7 days");
                emit OwnershipTransferred(_owner, _previousOwner);
                _owner = _previousOwner;
        }
}

interface IUniswapV2Factory {
        event PairCreated(address indexed token0, address indexed token1, address pair, uint);
        function feeTo() external view returns (address);
        function feeToSetter() external view returns (address);
        function getPair(address tokenA, address tokenB) external view returns (address pair);
        function allPairs(uint) external view returns (address pair);
        function allPairsLength() external view returns (uint);
        function createPair(address tokenA, address tokenB) external returns (address pair);
        function setFeeTo(address) external;
        function setFeeToSetter(address) external;
}

interface IUniswapV2Pair {
        event Approval(address indexed owner, address indexed spender, uint value);
        event Transfer(address indexed from, address indexed to, uint value);
        function name() external pure returns (string memory);
        function symbol() external pure returns (string memory);
        function decimals() external pure returns (uint8);
        function totalSupply() external view returns (uint);
        function balanceOf(address owner) external view returns (uint);
        function allowance(address owner, address spender) external view returns (uint);
        function approve(address spender, uint value) external returns (bool);
        function transfer(address to, uint value) external returns (bool);
        function transferFrom(address from, address to, uint value) external returns (bool);
        function DOMAIN_SEPARATOR() external view returns (bytes32);
        function PERMIT_TYPEHASH() external pure returns (bytes32);
        function nonces(address owner) external view returns (uint);
        function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;
        event Mint(address indexed sender, uint amount0, uint amount1);
        event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
        event Swap(address indexed sender, uint amount0In, uint amount1In, uint amount0Out, uint amount1Out, address indexed to);
        event Sync(uint112 reserve0, uint112 reserve1);
        function MINIMUM_LIQUIDITY() external pure returns (uint);
        function factory() external view returns (address);
        function token0() external view returns (address);
        function token1() external view returns (address);
        function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
        function price0CumulativeLast() external view returns (uint);
        function price1CumulativeLast() external view returns (uint);
        function kLast() external view returns (uint);
        function mint(address to) external returns (uint liquidity);
        function burn(address to) external returns (uint amount0, uint amount1);
        function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
        function skim(address to) external;
        function sync() external;
        function initialize(address, address) external;
}

interface IUniswapV2Router01 {
        function factory() external pure returns (address);
        function WETH() external pure returns (address);
        function addLiquidity( address tokenA, address tokenB, uint amountADesired, uint amountBDesired, uint amountAMin, uint amountBMin, address to, uint deadline
        ) external returns (uint amountA, uint amountB, uint liquidity);
        function addLiquidityETH( address token, uint amountTokenDesired, uint amountTokenMin, uint amountETHMin, address to, uint deadline
        ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
        function removeLiquidity( address tokenA, address tokenB, uint liquidity, uint amountAMin, uint amountBMin, address to, uint deadline
        ) external returns (uint amountA, uint amountB);
        function removeLiquidityETH( address token, uint liquidity, uint amountTokenMin, uint amountETHMin, address to, uint deadline
        ) external returns (uint amountToken, uint amountETH);
        function removeLiquidityWithPermit( address tokenA, address tokenB, uint liquidity, uint amountAMin, uint amountBMin, address to, uint deadline, bool approveMax, uint8 v, bytes32 r, bytes32 s
        ) external returns (uint amountA, uint amountB);
        function removeLiquidityETHWithPermit( address token, uint liquidity, uint amountTokenMin, uint amountETHMin, address to, uint deadline, bool approveMax, uint8 v, bytes32 r, bytes32 s
        ) external returns (uint amountToken, uint amountETH);
        function swapExactTokensForTokens( uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline
        ) external returns (uint[] memory amounts);
        function swapTokensForExactTokens( uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline
        ) external returns (uint[] memory amounts);
        function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline) external payable returns (uint[] memory amounts);
        function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline) external returns (uint[] memory amounts);
        function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline) external returns (uint[] memory amounts);
        function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline) external payable returns (uint[] memory amounts);
        function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
        function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
        function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
        function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
        function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

interface IUniswapV2Router02 is IUniswapV2Router01 {
        function removeLiquidityETHSupportingFeeOnTransferTokens( address token, uint liquidity, uint amountTokenMin, uint amountETHMin, address to, uint deadline) external returns (uint amountETH);
        function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens( address token, uint liquidity, uint amountTokenMin, uint amountETHMin, address to, uint deadline, bool approveMax, uint8 v, bytes32 r, bytes32 s) external returns (uint amountETH);
        function swapExactTokensForTokensSupportingFeeOnTransferTokens( uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline) external;
        function swapExactETHForTokensSupportingFeeOnTransferTokens( uint amountOutMin, address[] calldata path, address to, uint deadline) external payable;
        function swapExactTokensForETHSupportingFeeOnTransferTokens( uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline) external;
}

contract KonkinPublishings is Context, IERC20, Ownable, ReentrancyGuard {
        using Address for address;

        mapping (address => uint256) private _rOwned;
        mapping (address => uint256) private _tOwned;
        mapping (address => mapping (address => uint256)) private _allowances;

        mapping (address => bool) private _isExcludedFromFee;
        mapping (address => bool) private _isExcludedFromReward;
        address[] private _excludedFromReward;

    // Burn address  0x0000000000000000000000000000000000000001
        // or address(0) 0x0000000000000000000000000000000000000000
        // or 0x0::dEaD
        address BURN_ADDRESS = 0x000000000000000000000000000000000000dEaD;

    // Editor address
    address EDITOR_ADDRESS = replace_ME;

        // Liquidity address
        address LIQUIDITY_ADDRESS = replace_ME;

        uint256 private constant MAX = ~uint256(0);
        uint256 private _tTotal = 19501019 * 10**8;
        uint256 private _rTotal = (MAX - (MAX % _tTotal));
        uint256 private _tEditorFeeTotal;
        uint256 private _tHolderRewardsTotal;
        uint256 private _tLiquidityFeeTotal;

        string private _name = "Editora Konkin";
        string private _symbol = "KONKIN";

    // NOTE: decimals are now handled directly on decimals() function
    // uint8 private _decimals = 8;

    uint256 public _editorFee = 1;
    uint256 private _previousEditorFee = _editorFee;

        uint256 public _rewardFee = 1;
        uint256 private _previousRewardFee = _rewardFee;

        uint256 public _liquidityFee = 1;
        uint256 private _previousLiquidityFee = _liquidityFee;

        uint256 public _burnFee = 1;
        uint256 private _previousBurnFee = _burnFee;

        IUniswapV2Router02 public immutable uniswapV2Router;
        address public immutable uniswapV2Pair;
        uint256 public _maxTxAmount = (19501019 / 2) * 10**8;

        event Burn(address indexed from, address indexed burnAddress, uint256 value);

        // Struct for transaction values
    struct TxValues {
        uint256 Amount;
        uint256 TransferAmount;
        uint256 EditorFee;
        uint256 HolderFee;
                uint256 LiquidityFee;
        uint256 Burn;
    }

        // Assign token variables on constructor or on compile time.?
        constructor () {
                _rOwned[_msgSender()] = _rTotal;

                //pancake v2 testnet router 0xD99D1c33F9fC3444f8101754aBC46c52416550D1
                //pancake v2 mainnet router 0x10ED43C718714eb63d5aA57B78B54704E256024E
                IUniswapV2Router02 _uniswapV2Router = IUniswapV2Router02(0xD99D1c33F9fC3444f8101754aBC46c52416550D1);           // binance PANCAKE V2
                //IUniswapV2Router02 _uniswapV2Router = IUniswapV2Router02(0x05fF2B0DB69458A0750badebc4f9e13aDd608C7F);         // binance PANCAKE V1 mainnet
                //IUniswapV2Router02 _uniswapV2Router = IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);         // Ethereum mainnet, Ropsten, Rinkeby, Görli, and Kovan          
                uniswapV2Pair = IUniswapV2Factory(_uniswapV2Router.factory()).createPair(address(this), _uniswapV2Router.WETH());
                uniswapV2Router = _uniswapV2Router;
                _isExcludedFromFee[owner()] = true;

                // Excludes the contract and burn address from fee and dividends rewards
                _isExcludedFromFee[address(this)] = true;
                _isExcludedFromReward[address(this)] = true;
                _isExcludedFromFee[BURN_ADDRESS] = true;
                _isExcludedFromReward[BURN_ADDRESS] = true;

                // Excludes the EDITOR and LIQUIDITY adresses from fee and dividends rewards
                _isExcludedFromFee[EDITOR_ADDRESS] = true;
                _isExcludedFromReward[EDITOR_ADDRESS] = true;
                _isExcludedFromFee[LIQUIDITY_ADDRESS] = true;
                _isExcludedFromReward[LIQUIDITY_ADDRESS] = true;

                // Emits the Tranver event, tokens sent to contract deployer / owner
                emit Transfer(address(0), _msgSender(), _tTotal);
        }

        function name() public view returns (string memory) {return _name;}
        function symbol() public view returns (string memory) {return _symbol;}
        function decimals() public pure returns (uint8) {return 8;}
        function totalSupply() public view override returns (uint256) {return _tTotal;}

        function balanceOf(address account) public view override returns (uint256) {
                if (_isExcludedFromReward[account]) return _tOwned[account];
                return tokenFromReflection(_rOwned[account]);
        }

        function withdraw() external onlyOwner nonReentrant{
                uint256 balance = IERC20(address(this)).balanceOf(address(this));
                IERC20(address(this)).transfer(msg.sender, balance);
                payable(msg.sender).transfer(address(this).balance);
        }

        function transfer(address recipient, uint256 amount) public override returns (bool) {
                _transfer(_msgSender(), recipient, amount);
                return true;
        }

        function allowance(address owner, address spender) public view override returns (uint256) {
                return _allowances[owner][spender];
        }

        function approve(address spender, uint256 amount) public override returns (bool) {
                _approve(_msgSender(), spender, amount);
                return true;
        }

        function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
                _transfer(sender, recipient, amount);
                require(amount <= _allowances[sender][_msgSender()], "ERC20: transfer amount exceeds allowance");
                _approve(sender, _msgSender(), _allowances[sender][_msgSender()] - amount);
                return true;
        }

        function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
                _approve(_msgSender(), spender, _allowances[_msgSender()][spender] + addedValue);
                return true;
        }

        function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
                require(subtractedValue <= _allowances[_msgSender()][spender], "ERC20: decreased allowance below zero");
                _approve(_msgSender(), spender, _allowances[_msgSender()][spender] - subtractedValue);
                return true;
        }

    function totalEditorFees() public view returns(uint256){
        return _tEditorFeeTotal;
    }

        function totalHolderRewards() public view returns (uint256) {
                return _tHolderRewardsTotal;
        }

        function totalLiquidityFees() public view returns(uint256) {
                return _tLiquidityFeeTotal;
        }

        function totalBurned() public view returns (uint256) {
                return balanceOf(BURN_ADDRESS);
        }

        function totalEditorBalance() public view returns(uint256){
                return balanceOf(EDITOR_ADDRESS);
        }

        // Allows a non excluded from reflections address to reduce its rewards token amount
        // to increase non-excluded addresses balances
        function deliver(uint256 tAmount) public {
                address sender = _msgSender();
                require(!_isExcludedFromReward[sender], "Excluded addresses cannot call this function");
                (TxValues memory rValues,) = _getValues(tAmount);
                _rOwned[sender] -= rValues.Amount;
                _rTotal -= rValues.Amount;
                _tHolderRewardsTotal += tAmount;
        }

        function reflectionFromToken(uint256 tAmount, bool deductTransferFee) public view returns(uint256) {
                require(tAmount <= _tTotal, "Amount must be less than supply");
                if (!deductTransferFee) {
                        (TxValues memory rValues,) = _getValues(tAmount);
                        return rValues.Amount;
                } else {
                        (TxValues memory rValues,) = _getValues(tAmount);
                        return rValues.TransferAmount;
                }
        }

        function tokenFromReflection(uint256 rAmount) public view returns(uint256) {
                require(rAmount <= _rTotal, "Amount must be less than total reflections");
                uint256 currentRate =  _getRate();
                return rAmount / currentRate;
        }

        function isExcludedFromReward(address account) public view returns (bool) {
                return _isExcludedFromReward[account];
        }

        function excludeFromReward(address account) public onlyOwner {
                require(!_isExcludedFromReward[account], "Account is already excluded");
                if(_rOwned[account] > 0) {
                        _tOwned[account] = tokenFromReflection(_rOwned[account]);
                }
                _isExcludedFromReward[account] = true;
                _excludedFromReward.push(account);
        }

        function includeInReward(address account) external onlyOwner {
                require(_isExcludedFromReward[account], "Account is already excluded");
                for (uint256 i = 0; i < _excludedFromReward.length; i++) {
                        if (_excludedFromReward[i] == account) {
                                _excludedFromReward[i] = _excludedFromReward[_excludedFromReward.length - 1];
                                _tOwned[account] = 0;
                                _isExcludedFromReward[account] = false;
                                _excludedFromReward.pop();
                                break;
                        }
                }
        }

        function excludeFromFee(address account) public onlyOwner {
                _isExcludedFromFee[account] = true;
        }

        function includeInFee(address account) public onlyOwner {
                _isExcludedFromFee[account] = false;
        }

    function setEditorFeePercent(uint256 editorFee) external onlyOwner {
                require(editorFee <= 1, "Editor Fee must be 0 or 1%");
        _editorFee = editorFee;
    }

        function setRewardFeePercent(uint256 rewardFee) external onlyOwner {
                require(rewardFee <= 1, "Reward Fee must be 0 or 1%");
                _rewardFee = rewardFee;
        }

        function setLiquidityFeePercent(uint256 liquidityFee) external onlyOwner {
                require(liquidityFee <= 1, "Liquidity Fee must be 0 or 1%");
                _liquidityFee = liquidityFee;
        }

        function setBurnFeePercent(uint256 burnFee) external onlyOwner {
                require(burnFee <= 1, "Burn Fee must be 0 or 1%");
                _burnFee = burnFee;
        }

        function setMaxTxPercent(uint256 maxTxPercent) external onlyOwner {
                _maxTxAmount = _tTotal * maxTxPercent / 10**2;
        }

        receive() external payable {}

    // Transfers Editor Fee to EDITOR_ADDRESS
    function _transferEditorFee(uint256 rEditorFee, uint256 tEditorFee) private{
        _rTotal -= rEditorFee;
        _rOwned[EDITOR_ADDRESS] += rEditorFee;
                if(_isExcludedFromReward[EDITOR_ADDRESS])
                _tOwned[EDITOR_ADDRESS] += tEditorFee;
                _tEditorFeeTotal += tEditorFee;
    }

        // Adds balance to dividends rewards
        function _HolderFee(uint256 rHolderFee, uint256 tHolderFee) private {
                _rTotal -= rHolderFee;
                _tHolderRewardsTotal += tHolderFee;
        }

    // Transfers Liquidity Fee to LIQUIDITY_ADDRESS
        function _transferLiquidityFee(uint256 rLiquidityFee, uint256 tLiquidityFee) private {
                _rTotal -= rLiquidityFee;
                _rOwned[LIQUIDITY_ADDRESS] += rLiquidityFee;
                if(_isExcludedFromReward[LIQUIDITY_ADDRESS])
                        _tOwned[LIQUIDITY_ADDRESS] += tLiquidityFee;
                _tLiquidityFeeTotal += tLiquidityFee;
        }


        function _getValues(uint256 tAmount) private view returns (TxValues memory, TxValues memory) {
                TxValues memory tValues = _getTValues(tAmount);
                TxValues memory rValues = _getRValues(tAmount, tValues.EditorFee, tValues.HolderFee, tValues.LiquidityFee, tValues.Burn, _getRate());
                return (rValues, tValues);
        }

        // Gets Token values
        function _getTValues(uint256 tAmount) private view returns (TxValues memory) {
        TxValues memory tValues;
        tValues.EditorFee = calculateEditorFee(tAmount);
        tValues.HolderFee = calculateRewardFee(tAmount);
                tValues.LiquidityFee = calculateLiquidityFee(tAmount);
                tValues.Burn = calculateBurnFee(tAmount);
                tValues.TransferAmount = tAmount - tValues.LiquidityFee - tValues.HolderFee - tValues.Burn - tValues.EditorFee;
                return tValues;
        }

        // Gets Reflections values
        function _getRValues(uint256 tAmount, uint256 tEditorFee, uint256 tHolderFee, uint256 tLiquidityFee, uint256 tBurn, uint256 currentRate) private pure returns (TxValues memory) {
                TxValues memory rValues;
        rValues.Amount = tAmount * currentRate;
        rValues.EditorFee = tEditorFee * currentRate;
                rValues.HolderFee = tHolderFee * currentRate;
                rValues.LiquidityFee = tLiquidityFee * currentRate;
                rValues.Burn = tBurn * currentRate;
                rValues.TransferAmount = rValues.Amount - rValues.LiquidityFee - rValues.HolderFee - rValues.Burn - rValues.EditorFee;
                return rValues;
        }

        // Gets the rate of reflections / tokens
        function _getRate() private view returns(uint256) {
                (uint256 rSupply, uint256 tSupply) = _getCurrentSupply();
                return rSupply / tSupply;
        }

        function _getCurrentSupply() private view returns(uint256, uint256) {
                uint256 rSupply = _rTotal;
                uint256 tSupply = _tTotal;
                for (uint256 i = 0; i < _excludedFromReward.length; i++) {
                        if (_rOwned[_excludedFromReward[i]] > rSupply || _tOwned[_excludedFromReward[i]] > tSupply) return (_rTotal, _tTotal);
                        rSupply -= _rOwned[_excludedFromReward[i]];
                        tSupply -= _tOwned[_excludedFromReward[i]];
                }
                if (rSupply < _rTotal / _tTotal) return (_rTotal, _tTotal);
                return (rSupply, tSupply);
        }

    function calculateEditorFee(uint256 _amount) private view returns(uint256){
        return _amount * _editorFee / 10**2;
    }

        function calculateRewardFee(uint256 _amount) private view returns (uint256) {
                return _amount * _rewardFee / 10**2;
        }

        function calculateLiquidityFee(uint256 _amount) private view returns (uint256) {
                return _amount * _liquidityFee / 10**2;
        }

        function calculateBurnFee(uint256 _amount) private view returns (uint256) {
                return _amount * _burnFee / 10**2;
        }

        function removeAllFee() private {
                if(_editorFee == 0 && _rewardFee == 0 && _burnFee == 0) return;
                _previousEditorFee = _editorFee;
        _previousRewardFee = _rewardFee;
                _previousLiquidityFee = _liquidityFee;
                _previousBurnFee = _burnFee;
        _editorFee = 0;
                _rewardFee = 0;
                _liquidityFee = 0;
                _burnFee = 0;
        }

        function restoreAllFee() private {
        _editorFee = _previousEditorFee;
                _rewardFee = _previousRewardFee;
                _liquidityFee = _previousLiquidityFee;
                _burnFee = _previousBurnFee;
        }

        // Returns true if account is excluded from fees
        function isExcludedFromFee(address account) public view returns(bool) {
                return _isExcludedFromFee[account];
        }

        // Lets user burn its own tokens
        function burn(uint256 tAmount) public {
                address sender = _msgSender();
                uint256 reflectionsBalance = _rOwned[sender];
                uint256 tokenBalance = tokenFromReflection(reflectionsBalance);

                if (_isExcludedFromReward[sender])
                        tokenBalance = _tOwned[sender];

                require(tAmount <= tokenBalance, "Token burn amount must be less or equal to token balance");

                uint256 currentRate = _getRate();
                uint256 rAmount = tAmount * currentRate;

                if (_isExcludedFromReward[sender]){
                        _tOwned[sender] -= tAmount;
                }
                _rOwned[sender] -= rAmount;

                _transferBurn(tAmount);

                emit Burn(sender, BURN_ADDRESS, tAmount);
        }

        function _approve(address owner, address spender, uint256 amount) private {
                require(owner != address(0), "ERC20: approve from the zero address");
                require(spender != address(0), "ERC20: approve to the zero address");
                _allowances[owner][spender] = amount;
                emit Approval(owner, spender, amount);
        }

        function _transfer(
                address from,
                address to,
                uint256 amount
        ) private {
                require(from != address(0), "ERC20: transfer from the zero address");
                require(to != address(0), "ERC20: transfer to the zero address");
                require(amount > 0, "Transfer amount must be greater than zero");
                if(from != owner() && to != owner())
                        require(amount <= _maxTxAmount, "Transfer amount exceeds the maxTxAmount.");
                bool takeFee = true;
                if(_isExcludedFromFee[from] || _isExcludedFromFee[to]){
                        takeFee = false;
                }
                _tokenTransfer(from,to,amount,takeFee);
        }
        function _tokenTransfer(address sender, address recipient, uint256 amount,bool takeFee) private {
                if(!takeFee)
                        removeAllFee();
                if (_isExcludedFromReward[sender] && !_isExcludedFromReward[recipient]) {
                        _transferFromExcluded(sender, recipient, amount);
                } else if (!_isExcludedFromReward[sender] && _isExcludedFromReward[recipient]) {
                        _transferToExcluded(sender, recipient, amount);
                } else if (!_isExcludedFromReward[sender] && !_isExcludedFromReward[recipient]) {
                        _transferStandard(sender, recipient, amount);
                } else if (_isExcludedFromReward[sender] && _isExcludedFromReward[recipient]) {
                        _transferBothExcluded(sender, recipient, amount);
                } else {
                        _transferStandard(sender, recipient, amount);
                }
                if(!takeFee)
                        restoreAllFee();
        }


        function _transferBurn(uint256 tBurn) private {
                uint256 currentRate = _getRate();
                uint256 rBurn = tBurn * currentRate;
                _rOwned[BURN_ADDRESS] += rBurn;
                if(_isExcludedFromReward[BURN_ADDRESS])
                        _tOwned[BURN_ADDRESS] += tBurn;
        }

        function _transferFromExcluded(address sender, address recipient, uint256 tAmount) private {
                (TxValues memory rValues, TxValues memory tValues) = _getValues(tAmount);
                _tOwned[sender] = _tOwned[sender]- tAmount;
                _rOwned[sender] = _rOwned[sender]- rValues.Amount;
                _rOwned[recipient] = _rOwned[recipient] + rValues.TransferAmount;
                _transferBurn(tValues.Burn);
        _transferEditorFee(rValues.EditorFee, tValues.EditorFee);
                _HolderFee(rValues.HolderFee, tValues.HolderFee);
                _transferLiquidityFee(rValues.LiquidityFee, tValues.LiquidityFee);
                emit Burn(sender, BURN_ADDRESS, tValues.Burn);
                emit Transfer(sender, recipient, tValues.TransferAmount);
        }

        function _transferToExcluded(address sender, address recipient, uint256 tAmount) private {
                (TxValues memory rValues, TxValues memory tValues) = _getValues(tAmount);
                _rOwned[sender] -=  rValues.Amount;
                _tOwned[recipient] += tValues.TransferAmount;
                _rOwned[recipient] += rValues.TransferAmount;
                _transferBurn(tValues.Burn);
        _transferEditorFee(rValues.EditorFee, tValues.EditorFee);
                _HolderFee(rValues.HolderFee, tValues.HolderFee);
                _transferLiquidityFee(rValues.LiquidityFee, tValues.LiquidityFee);
                emit Burn(sender, BURN_ADDRESS, tValues.Burn);
                emit Transfer(sender, recipient, tValues.TransferAmount);
        }

        function _transferStandard(address sender, address recipient, uint256 tAmount) private {
                (TxValues memory rValues, TxValues memory tValues) = _getValues(tAmount);
                _rOwned[sender] -= rValues.Amount;
                _rOwned[recipient] += rValues.TransferAmount;
                _transferBurn(tValues.Burn);
        _transferEditorFee(rValues.EditorFee, tValues.EditorFee);
                _HolderFee(rValues.HolderFee, tValues.HolderFee);
                _transferLiquidityFee(rValues.LiquidityFee, tValues.LiquidityFee);
                emit Burn(sender, BURN_ADDRESS, tValues.Burn);
                emit Transfer(sender, recipient, tValues.TransferAmount);
        }

        function _transferBothExcluded(address sender, address recipient, uint256 tAmount) private {
                (TxValues memory rValues, TxValues memory tValues) = _getValues(tAmount);
                _tOwned[sender] -= tAmount;
                _rOwned[sender] -= rValues.Amount;
                _tOwned[recipient] += tValues.TransferAmount;
                _rOwned[recipient] += rValues.TransferAmount;
                _transferBurn(tValues.Burn);
        _transferEditorFee(rValues.EditorFee, tValues.EditorFee);
                _HolderFee(rValues.HolderFee, tValues.HolderFee);
                _transferLiquidityFee(rValues.LiquidityFee, tValues.LiquidityFee);
                emit Burn(sender, BURN_ADDRESS, tValues.Burn);
                emit Transfer(sender, recipient, tValues.TransferAmount);
        }

}
