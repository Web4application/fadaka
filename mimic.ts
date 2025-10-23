import { Token, Transfer, USD, TokenAmount } from '@mimicprotocol/lib-ts'
import { inputs } from './types'
import { ERC20 } from './types/ERC20'

  export default function main(): void {
    const tokenContract = new ERC20(inputs.token, inputs.chainId)
    const balance = tokenContract.balanceOf(inputs.recipient)

    const token = Token.fromAddress(inputs.token, inputs.chainId)
    const balanceInUsd = TokenAmount.fromBigInt(token, balance).toUsd()
    const thresholdUsd = USD.fromI32(inputs.thresholdUSD)
    console.log('Balance in USD: ' + balanceInUsd.toString())

    if (balanceInUsd.lt(thresholdUsd)) {
      Transfer
        .create(inputs.chainId, inputs.token, inputs.amount, inputs.recipient, inputs.fee)
        }
     }
