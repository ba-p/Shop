/** @jsxImportSource @emotion/react */
import "twin.macro";
import React from "react";

import { SimpleMenu, MenuItem } from "@rmwc/menu";
import { ReactComponent as ArrowDown } from "asset/icons/arrow_down.svg";
import { ReactComponent as Plus } from "asset/icons/plus.svg";
import { ReactComponent as Minus } from "asset/icons/minus.svg";
import { ProductItem } from "models/utils.model";
import { useState } from "react";
import { numberToVND } from "utils/utils";

type Props = {
  item: ProductItem;
};
export const PaymentItem = (props: Props) => {
  const { item } = props;
  const [currentIndex, setCurrentIndex] = useState(0);

  return (
    <div tw="ml-auto mr-auto mb-5 width[50%] h-32 border-b-2 border-solid border-gray-100 p-3">
      <div tw="flex space-x-10">
        <div
          tw="w-24 h-24 bg-contain bg-no-repeat"
          style={{
            backgroundImage: `url('${
              process.env.PUBLIC_URL + "/images/" + item.anh[currentIndex]
            }')`,
          }}
        />
        <div tw="flex flex-grow justify-between">
          <div>
            <div tw="mb-3">{item.ten}</div>
            <SimpleMenu
              anchorCorner="bottomLeft"
              handle={
                <div tw="cursor-pointer border rounded-md flex p-1.5 items-center justify-between">
                  <div>{item.mau[currentIndex]}</div>
                  <ArrowDown />
                </div>
              }
            >
              {item.mau.map((mau, index) => {
                return (
                  <MenuItem onClick={() => setCurrentIndex(index)}>
                    <div tw="flex w-48 flex-grow space-x-3 items-center">
                      <div tw="border border-style-purple-1 p-0.5">
                        <div
                          tw="w-8 h-8 bg-contain bg-no-repeat"
                          style={{
                            backgroundImage: `url('${
                              process.env.PUBLIC_URL +
                              "/images/" +
                              item.anh[index]
                            }')`,
                          }}
                        />
                      </div>
                      <div>{mau}</div>
                    </div>
                  </MenuItem>
                );
              })}
            </SimpleMenu>
          </div>
          <div>
            <div tw="mb-5">{numberToVND(item.gia[0])}</div>
            <div tw="flex">
              <div tw="flex items-center border p-1 w-6 h-6 justify-center">
                <Minus width={10} height={10} />
              </div>
              <input
                tw="width[2rem]! text-center outline-none ml-0.5 mr-0.5 mb-0! bg-gray-100"
                // css={numberNoArrow}
                type="number"
                value={1}
                // onKeyDown={handleKeyDown}
                // onBlur={dispatchGotoPage}
                // onChange={(e) => setPageInput(e.target.value)}
                min={1}
                // max={totalPage}
              />
              <div tw="flex items-center border p-1 w-6 h-6 justify-center">
                <Plus width={10} height={10} />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};
