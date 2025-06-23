import "@openzeppelin/contracts-upgradeable/*";

contract FadakaToken is Initializable, ERC20Upgradeable, OwnableUpgradeable, PausableUpgradeable {
    function initialize() public initializer {
        __ERC20_init("Fadaka Token", "FDAK");
        __Ownable_init();
        __Pausable_init();
        _mint(msg.sender, 1_000_000_000 * 10 ** decimals());
    }
    /* mint, burn, pause logic */
}
