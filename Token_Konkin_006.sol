KnZ?
#2477

kurobaketsu — 24/03/2022
p → q
KnZ? — 24/03/2022
sexo anal?
kurobaketsu — 24/03/2022
aí é com a galera do fh
KnZ? — 24/03/2022
fraternindade hindigena
kurobaketsu — 24/03/2022
sim cheio de indiano
KnZ? — 24/03/2022
com cor de preto
kurobaketsu — 24/03/2022
digitando em teclado mecânico
KnZ? — 24/03/2022
preto = negro mt mt fedido
eca
kurobaketsu — 24/03/2022
com mic estourado
KnZ? — 24/03/2022
um negro coça o cu
outro negro olha e diz
hm
cocei o cu
..
kurobaketsu — 24/03/2022
tirinhas de enem aí
KnZ? — 24/03/2022
meu saco
ta peludo
kurobaketsu — 24/03/2022
mané
onde tu pegou aquele video do miorim lendo ingles
KnZ? — 24/03/2022
KKKKKKKKKKKK
PQ?
!!
!
kurobaketsu — 24/03/2022
to rindo até agora
sefuder
KnZ? — 24/03/2022
JULIO ENVIOU
kurobaketsu — 24/03/2022
kkkkkkkkkkkkkkk
aí mané vou dormir pra acordar cedo
KnZ? — 24/03/2022
VAÇLEUUUUUUUUUUUUUUUUUUU
TE AMO VIALEU
!
kurobaketsu — 24/03/2022
Se tu quiser cria uma conta  no moralis pra  pegar api pra clonar a rede no hardhat também: https://admin.moralis.io/speedyNodes
Moralis Admin
Build Serverless web3 apps without having to worry about backend infrastructure
FALEUUU
KnZ? — 24/03/2022
certo
euvaleu
kurobaketsu — 25/03/2022
maluco fazendo jogo inteiro em visual script
kurobaketsu — 25/03/2022
iuehiaeuheui
kurobaketsu — Hoje às 22:39
AE
TA AE
KnZ? — Hoje às 22:54
s
ae
cade tu
KnZ?
 iniciou uma chamada.
 — Hoje às 23:01
kurobaketsu — Hoje às 23:02
iee
apaguei a parte de liquidez
pra fazer de novo
to
perae
pra nao gastar token nem interferir na net real é bomn testar em localhost antes
pra ter certeza que tá tudo ok antes de upar numa testnet
mas perae
tu vai colocar no github publico?
// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.0;

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

library SafeMath {
	function add(uint256 a, uint256 b) internal pure returns (uint256) {uint256 c = a + b; require(c >= a, "SafeMath: addition overflow"); return c;}	
	function sub(uint256 a, uint256 b) internal pure returns (uint256) {return sub(a, b, "SafeMath: subtraction overflow");}
	function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {require(b <= a, errorMessage);uint256 c = a - b;return c;}
	function mul(uint256 a, uint256 b) internal pure returns (uint256) {if (a == 0) {return 0;}uint256 c = a * b;require(c / a == b, "SafeMath: multiplication overflow");return c;}
	function div(uint256 a, uint256 b) internal pure returns (uint256) {return div(a, b, "SafeMath: division by zero");}
	function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {require(b > 0, errorMessage);uint256 c = a / b;return c;}
	function mod(uint256 a, uint256 b) internal pure returns (uint256) {return mod(a, b, "SafeMath: modulo by zero");}
	function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {require(b != 0, errorMessage);return a % b;}
}

abstract contract Context {
	function _msgSender() internal view virtual returns (address) {return msg.sender;}
	function _msgData() internal view virtual returns (bytes memory) {this;return msg.data;}
}

library Address {
	
	function isContract(address account) internal view returns (bool) {
		bytes32 codehash;
		bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
		// solhint-disable-next-line no-inline-assembly
		assembly { codehash := extcodehash(account) }
		return (codehash != accountHash && codehash != 0x0);
	}

	function sendValue(address payable recipient, uint256 amount) internal {
		require(address(this).balance >= amount, "Address: insufficient balance");
		// solhint-disable-next-line avoid-low-level-calls, avoid-call-value
		(bool success, ) = recipient.call{ value: amount }("");
		require(success, "Address: unable to send value, recipient may have reverted");
	}

	function functionCall(address target, bytes memory data) internal returns (bytes memory) {
	  return functionCall(target, data, "Address: low-level call failed");
	}

	function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
		return _functionCallWithValue(target, data, 0, errorMessage);
	}

	function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
		return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
	}

	function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
		require(address(this).balance >= value, "Address: insufficient balance for call");
		return _functionCallWithValue(target, data, value, errorMessage);
	}

	function _functionCallWithValue(address target, bytes memory data, uint256 weiValue, string memory errorMessage) private returns (bytes memory) {
		require(isContract(target), "Address: call to non-contract");
		// solhint-disable-next-line avoid-low-level-calls
		(bool success, bytes memory returndata) = target.call{ value: weiValue }(data);
		if (success) {
			return returndata;
		} else {
			if (returndata.length > 0) {
				// solhint-disable-next-line no-inline-assembly
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
... (580 linhas)
Recolher
token_test_006.sol
31 KB
collaborators eu acho
sim
T
// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.0;

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

library SafeMath {
	function add(uint256 a, uint256 b) internal pure returns (uint256) {uint256 c = a + b; require(c >= a, "SafeMath: addition overflow"); return c;}	
	function sub(uint256 a, uint256 b) internal pure returns (uint256) {return sub(a, b, "SafeMath: subtraction overflow");}
	function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {require(b <= a, errorMessage);uint256 c = a - b;return c;}
	function mul(uint256 a, uint256 b) internal pure returns (uint256) {if (a == 0) {return 0;}uint256 c = a * b;require(c / a == b, "SafeMath: multiplication overflow");return c;}
	function div(uint256 a, uint256 b) internal pure returns (uint256) {return div(a, b, "SafeMath: division by zero");}
	function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {require(b > 0, errorMessage);uint256 c = a / b;return c;}
	function mod(uint256 a, uint256 b) internal pure returns (uint256) {return mod(a, b, "SafeMath: modulo by zero");}
	function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {require(b != 0, errorMessage);return a % b;}
}

abstract contract Context {
	function _msgSender() internal view virtual returns (address) {return msg.sender;}
	function _msgData() internal view virtual returns (bytes memory) {this;return msg.data;}
}

library Address {
	
	function isContract(address account) internal view returns (bool) {
		bytes32 codehash;
		bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
		// solhint-disable-next-line no-inline-assembly
		assembly { codehash := extcodehash(account) }
		return (codehash != accountHash && codehash != 0x0);
	}

	function sendValue(address payable recipient, uint256 amount) internal {
		require(address(this).balance >= amount, "Address: insufficient balance");
		// solhint-disable-next-line avoid-low-level-calls, avoid-call-value
		(bool success, ) = recipient.call{ value: amount }("");
		require(success, "Address: unable to send value, recipient may have reverted");
	}

	function functionCall(address target, bytes memory data) internal returns (bytes memory) {
	  return functionCall(target, data, "Address: low-level call failed");
	}

	function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
		return _functionCallWithValue(target, data, 0, errorMessage);
	}

	function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
		return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
	}

	function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
		require(address(this).balance >= value, "Address: insufficient balance for call");
		return _functionCallWithValue(target, data, value, errorMessage);
	}

	function _functionCallWithValue(address target, bytes memory data, uint256 weiValue, string memory errorMessage) private returns (bytes memory) {
		require(isContract(target), "Address: call to non-contract");
		// solhint-disable-next-line avoid-low-level-calls
		(bool success, bytes memory returndata) = target.call{ value: weiValue }(data);
		if (success) {
			return returndata;
		} else {
			if (returndata.length > 0) {
				// solhint-disable-next-line no-inline-assembly
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
		_owner = address(0);
		_lockTime = block.timestamp + time;
		emit OwnershipTransferred(_owner, address(0));
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
	function removeLiquidityETHSupportingFeeOnTransferTokens( address token, uint liquidity, uint amountTokenMin, uint amountETHMin, address to, uint deadline
	) external returns (uint amountETH);
	function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens( address token, uint liquidity, uint amountTokenMin, uint amountETHMin, address to, uint deadline, bool approveMax, uint8 v, bytes32 r, bytes32 s
	) external returns (uint amountETH);
	function swapExactTokensForTokensSupportingFeeOnTransferTokens( uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline
	) external;
	function swapExactETHForTokensSupportingFeeOnTransferTokens( uint amountOutMin, address[] calldata path, address to, uint deadline
	) external payable;
	function swapExactTokensForETHSupportingFeeOnTransferTokens( uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline
	) external;
}

contract TesKIN is Context, IERC20, Ownable, ReentrancyGuard {
	using SafeMath for uint256;
	using Address for address;

	mapping (address => uint256) private _rOwned;
	mapping (address => uint256) private _tOwned;
	mapping (address => mapping (address => uint256)) private _allowances;

	mapping (address => bool) private _isExcludedFromFee;
	mapping (address => bool) private _isExcludedFromReward;
	address[] private _excludedFromReward;

    // Burn address 0x0000000000000000000000000000000000000001
	address BURN_ADDRESS = address(0);

    // Editor address
	// hardhat network addr 0x8626f6940E2eb28930eFb4CeF49B2d1F2C9C1199
    address EDITOR_ADDRESS = 0x8626f6940E2eb28930eFb4CeF49B2d1F2C9C1199;

	// Liquidity address
	address LIQUIDITY_ADDRESS;
	
	uint256 private constant MAX = ~uint256(0);
	uint256 private _tTotal = 1000 * 10**6 * 10**8;
	uint256 private _rTotal = (MAX - (MAX % _tTotal));
	uint256 private _tEditorFeeTotal;
	uint256 private _tHolderRewardsTotal;
	uint256 private _tLiquidityFeeTotal;

	string private _name = "Project Name";
	string private _symbol = "NAME";
	
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
	uint256 public _maxTxAmount = 500 * 10**6 * 10**8;

	event Burn(address indexed from, address indexed burnAddress, uint256 value);

	// Assign token variables on constructor or on compile time.?
	constructor () {
		_rOwned[_msgSender()] = _rTotal;
		IUniswapV2Router02 _uniswapV2Router = IUniswapV2Router02(0x10ED43C718714eb63d5aA57B78B54704E256024E);		// binance PANCAKE V2
		//IUniswapV2Router02 _uniswapV2Router = IUniswapV2Router02(0x05fF2B0DB69458A0750badebc4f9e13aDd608C7F);		// binance PANCAKE V1
		//IUniswapV2Router02 _uniswapV2Router = IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);		// Ethereum mainnet, Ropsten, Rinkeby, Görli, and Kovan		 
		uniswapV2Pair = IUniswapV2Factory(_uniswapV2Router.factory()).createPair(address(this), _uniswapV2Router.WETH());
		uniswapV2Router = _uniswapV2Router;
		_isExcludedFromFee[owner()] = true;

		// Excludes the contract and burn address from fee and dividends rewards
		_isExcludedFromFee[address(this)] = true;
		_isExcludedFromReward[address(this)] = true;
		_isExcludedFromFee[BURN_ADDRESS] = true;
		_isExcludedFromReward[BURN_ADDRESS] = true;

		// Emits the Tranver event, tokens sent to contract deployer / owner
		emit Transfer(address(0), _msgSender(), _tTotal);
	}

	// ****** FOR TEST ONLY ******
	// REMOVE BEFORE PRODUCTION
	function decreaseTotalSupply(uint256 amount) external onlyOwner{
		uint256 rSupply = _rTotal;

		/// burning only the total diminishes the account's tokens balance 
		_tTotal -= amount;

		// also burning reflections breaks tracking of shares and supply
		_rTotal = rSupply.sub(reflectionFromToken(amount, false));
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
		_approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
		return true;
	}

	function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
		_approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
		return true;
	}

	function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
		_approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
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
		(uint256 rAmount,,,,,,,) = _getValues(tAmount);
		_rOwned[sender] = _rOwned[sender].sub(rAmount);
		_rTotal = _rTotal.sub(rAmount);
		_tHolderRewardsTotal = _tHolderRewardsTotal.add(tAmount);
	}

	function reflectionFromToken(uint256 tAmount, bool deductTransferFee) public view returns(uint256) {
		require(tAmount <= _tTotal, "Amount must be less than supply");
		if (!deductTransferFee) {
			(uint256 rAmount,,,,,,,) = _getValues(tAmount);
			return rAmount;
		} else {
			(,uint256 rTransferAmount,,,,,,) = _getValues(tAmount);
			return rTransferAmount;
		}
	}

	function tokenFromReflection(uint256 rAmount) public view returns(uint256) {
		require(rAmount <= _rTotal, "Amount must be less than total reflections");
		uint256 currentRate =  _getRate();
		return rAmount.div(currentRate);
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
        _editorFee = editorFee;
    }
	
	function setRewardFeePercent(uint256 rewardFee) external onlyOwner {
		_rewardFee = rewardFee;
	}
	
	function setBurnFeePercent(uint256 burnFee) external onlyOwner {
		_burnFee = burnFee;
	}
	
	function setMaxTxPercent(uint256 maxTxPercent) external onlyOwner {
		_maxTxAmount = _tTotal.mul(maxTxPercent).div(
			10**2
		);
	}

	receive() external payable {}

    // Transfers Editor Fee to EDITOR_ADDRESS
    function _transferEditorFee(uint256 rEditorFee, uint256 tEditorFee) private{
        _rTotal = _rTotal.sub(rEditorFee);
        _rOwned[EDITOR_ADDRESS] = _rOwned[EDITOR_ADDRESS].add(rEditorFee);
		if(_isExcludedFromReward[EDITOR_ADDRESS])
        	_tOwned[EDITOR_ADDRESS] = _tOwned[EDITOR_ADDRESS].add(tEditorFee);
		_tEditorFeeTotal = _tEditorFeeTotal.add(tEditorFee);
    }

	// Adds balance to dividends rewards
	function _HolderFee(uint256 rHolderFee, uint256 tHolderFee) private {
		_rTotal = _rTotal.sub(rHolderFee);
		_tHolderRewardsTotal = _tHolderRewardsTotal.add(tHolderFee);
	}

    // TODO: liquidityFee
	function _transferLiquidityFee(uint256 rLiquidityFee, uint256 tLiquidityFee) private {

	}

	// Struct for transaction values
    struct TxValues {
        uint256 Amount;
        uint256 TransferAmount;
        uint256 EditorFee;
        uint256 HolderFee;
        uint256 Burn;
    }

	function _getValues(uint256 tAmount) private view returns (uint256, uint256, uint256, uint256, uint256, uint256, uint256, uint256) {
		TxValues memory tValues = _getTValues(tAmount);
		TxValues memory rValues = _getRValues(tAmount, tValues.EditorFee, tValues.HolderFee, tValues.Burn, _getRate());
		return (rValues.Amount, rValues.TransferAmount, rValues.EditorFee, rValues.HolderFee, tValues.TransferAmount, tValues.EditorFee, tValues.HolderFee, tValues.Burn);
	}

	// Gets Token values
	function _getTValues(uint256 tAmount) private view returns (TxValues memory) {
        TxValues memory tValues;
        tValues.EditorFee = calculateEditorFee(tAmount);
        tValues.HolderFee = calculateRewardFee(tAmount);
		tValues.Burn = calculateBurnFee(tAmount);
		tValues.TransferAmount = tAmount.sub(tValues.HolderFee).sub(tValues.Burn).sub(tValues.EditorFee);
		return tValues;
	}

	// Gets Reflections values
	function _getRValues(uint256 tAmount, uint256 tEditorFee, uint256 tHolderFee, uint256 tBurn, uint256 currentRate) private pure returns (TxValues memory) {
		TxValues memory rValues;
        rValues.Amount = tAmount.mul(currentRate);
        rValues.EditorFee = tEditorFee.mul(currentRate);
		rValues.HolderFee = tHolderFee.mul(currentRate);
		rValues.Burn = tBurn.mul(currentRate);
		rValues.TransferAmount = rValues.Amount.sub(rValues.HolderFee).sub(rValues.Burn).sub(rValues.EditorFee);
		return rValues;
	}

	// Gets the rate of reflections / tokens
	function _getRate() private view returns(uint256) {
		(uint256 rSupply, uint256 tSupply) = _getCurrentSupply();
		return rSupply.div(tSupply);
	}

	function _getCurrentSupply() private view returns(uint256, uint256) {
		uint256 rSupply = _rTotal;
		uint256 tSupply = _tTotal;
		for (uint256 i = 0; i < _excludedFromReward.length; i++) {
			if (_rOwned[_excludedFromReward[i]] > rSupply || _tOwned[_excludedFromReward[i]] > tSupply) return (_rTotal, _tTotal);
			rSupply = rSupply.sub(_rOwned[_excludedFromReward[i]]);
			tSupply = tSupply.sub(_tOwned[_excludedFromReward[i]]);
		}
		if (rSupply < _rTotal.div(_tTotal)) return (_rTotal, _tTotal);
		return (rSupply, tSupply);
	}
	
    function calculateEditorFee(uint256 _amount) private view returns(uint256){
        return _amount.mul(_editorFee).div(10**2);
    }
	
	function calculateRewardFee(uint256 _amount) private view returns (uint256) {
		return _amount.mul(_rewardFee).div(10**2);
	}

	function calculateLiquidityFee(uint256 _amount) private view returns (uint256) {
		return _amount.mul(_liquidityFee).div(10**2);
	}

	function calculateBurnFee(uint256 _amount) private view returns (uint256) {
		return _amount.mul(_burnFee).div(10**2);
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
	
	function isExcludedFromFee(address account) public view returns(bool) {
		return _isExcludedFromFee[account];
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
		uint256 rBurn = tBurn.mul(currentRate);		
		_rOwned[BURN_ADDRESS] = _rOwned[BURN_ADDRESS].add(rBurn);
		if(_isExcludedFromReward[BURN_ADDRESS])
			_tOwned[BURN_ADDRESS] = _tOwned[BURN_ADDRESS].add(tBurn);
	}

	function _transferFromExcluded(address sender, address recipient, uint256 tAmount) private {
		(
			uint256 rAmount,
			uint256 rTransferAmount,
            uint256 rEditorFee,
			uint256 rHolderFee,
			uint256 tTransferAmount,
            uint256 tEditorFee,
			uint256 tHolderFee,
			uint256 tBurn
		) = _getValues(tAmount);
		_tOwned[sender] = _tOwned[sender].sub(tAmount);
		_rOwned[sender] = _rOwned[sender].sub(rAmount);
		_rOwned[recipient] = _rOwned[recipient].add(rTransferAmount);
		_transferBurn(tBurn);
        _transferEditorFee(rEditorFee, tEditorFee);
		_HolderFee(rHolderFee, tHolderFee);
		emit Burn(sender, BURN_ADDRESS, tBurn);
		emit Transfer(sender, recipient, tTransferAmount);
	}
	
	function _transferToExcluded(address sender, address recipient, uint256 tAmount) private {
		(uint256 rAmount, uint256 rTransferAmount, uint256 rEditorFee, uint256 rHolderFee, uint256 tTransferAmount, uint256 tEditorFee, uint256 tHolderFee, uint256 tBurn) = _getValues(tAmount);
		_rOwned[sender] = _rOwned[sender].sub(rAmount);
		_tOwned[recipient] = _tOwned[recipient].add(tTransferAmount);
		_rOwned[recipient] = _rOwned[recipient].add(rTransferAmount);
		_transferBurn(tBurn);
        _transferEditorFee(rEditorFee, tEditorFee);
		_HolderFee(rHolderFee, tHolderFee);		
		emit Burn(sender, BURN_ADDRESS, tBurn);
		emit Transfer(sender, recipient, tTransferAmount);
	}
	
	function _transferStandard(address sender, address recipient, uint256 tAmount) private {
		(uint256 rAmount, uint256 rTransferAmount, uint256 rEditorFee, uint256 rHolderFee, uint256 tTransferAmount, uint256 tEditorFee, uint256 tHolderFee, uint256 tBurn) = _getValues(tAmount);
		_rOwned[sender] = _rOwned[sender].sub(rAmount);
		_rOwned[recipient] = _rOwned[recipient].add(rTransferAmount);
		_transferBurn(tBurn);
        _transferEditorFee(rEditorFee, tEditorFee);
		_HolderFee(rHolderFee, tHolderFee);
		emit Burn(sender, BURN_ADDRESS, tBurn);
		emit Transfer(sender, recipient, tTransferAmount);
	}

	function _transferBothExcluded(address sender, address recipient, uint256 tAmount) private {
		(uint256 rAmount, uint256 rTransferAmount, uint256 rEditorFee, uint256 rHolderFee, uint256 tTransferAmount, uint256 tEditorFee, uint256 tHolderFee, uint256 tBurn) = _getValues(tAmount);
		_tOwned[sender] = _tOwned[sender].sub(tAmount);
		_rOwned[sender] = _rOwned[sender].sub(rAmount);
		_tOwned[recipient] = _tOwned[recipient].add(tTransferAmount);
		_rOwned[recipient] = _rOwned[recipient].add(rTransferAmount);
		_transferBurn(tBurn);
        _transferEditorFee(rEditorFee, tEditorFee);
		_HolderFee(rHolderFee, tHolderFee);
		emit Burn(sender, BURN_ADDRESS, tBurn);
		emit Transfer(sender, recipient, tTransferAmount);
	}

}
